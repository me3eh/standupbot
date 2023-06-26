SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'evening_saving' do |params|
    user_id = params.dig(:payload, :user, :id)
    channel_id = params.dig(:payload, :container, :channel_id)
    team_id = params.dig(:payload, :user, :team_id)

    slack_client = Services::GetSlackClient.call(team_id: team_id)
    name, pic = Services::GetUserNameAndPicture.call(team_id: team_id, user_id: user_id)
    responds = Services::GatherRespondsFromEvening.new(params).call

    date_now = Date.today
    ts = params.dig(:payload, :container, :message_ts)

    evening_standup = Services::EveningStandup.new
    ts_message = evening_standup.call(ts: ts, slack_client: slack_client, channel_id: channel_id,
                                      text_for_header: 'Evening Standup!', pic: pic, responds: responds, username: name)[:ts]

    create_new_object_in_database = StandupCheck.create!(
      team: team_id,
      user_id: user_id,
      evening_stand: true,
      date_of_stand: date_now,
      ts_of_message_evening: ts_message,
      channel_of_message_evening: channel_id,
      evening_first: responds[:first_input],
      evening_second: responds[:second_input],
      evening_third: responds[:third_input],
      prs_and_estimation: responds[:prs]
    )

    Services::HideMessage.call(params[:payload][:response_url])
  end
end

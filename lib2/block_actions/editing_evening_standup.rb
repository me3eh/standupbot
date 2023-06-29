SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'evening_editing' do |params|
    user_id = params.dig(:payload, :user, :id)
    channel_id = params.dig(:payload, :container, :channel_id)
    team_id = params.dig(:payload, :user, :team_id)

    slack_client = Services::GetSlackClient.call(team_id: team_id)
    name, pic = Services::GetUserNameAndPicture.call(team_id: team_id, user_id: user_id)
    responds = Services::GatherRespondsFromEvening.new(params).call

    date_now = Date.today

    standup_ts = StandupBuffer.find_by(user_id: user_id, team_id: team_id)
    standup = StandupCheck.find_by(ts_of_message_evening: standup_ts&.message_timestamp)

    if standup.nil? || standup_ts.nil?
      slack_client.chat_postEphemeral(
        user: user_id,
        channel: channel_id,
        text: 'A najwidoczniej standupik uległ już zniszczeniu/został edytowany/coś zrobiłeś innego.',
        )
    else
      message_timestamp = standup_ts.message_timestamp

      evening_standup = Services::EveningStandup.new
      ts_message = evening_standup.call(ts: message_timestamp, slack_client: slack_client, channel_id: channel_id,
                                        responds: responds, text_for_header: 'Wieczorny standup!', pic: pic,
                                        username: name)[:ts]
      update_new_object_in_database = standup.update!(
          team: team_id,
          user_id: user_id,
          evening_stand: true,
          date_of_stand: date_now,
          ts_of_message_evening: ts_message,
          channel_of_message_evening: channel_id,
          evening_first: responds[:first_input],
          evening_second: responds[:second_input],
          evening_third: responds[:third_input],
          evening_fourth: responds[:fourth_input],
          prs_and_estimation: responds[:prs]
        )
    end

    Services::HideMessage.call(params[:payload][:response_url])
  end
end

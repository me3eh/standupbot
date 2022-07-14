SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'morning_deleting_and_saving' do |action|
    user_id = action[:payload][:user][:id]
    channel_id = action[:payload][:container][:channel_id]
    team_id = action[:payload][:user][:team_id]
    # slack_client = $everything_needed.get_slack_client(team_id: team_id)
    # name, pic = $everything_needed.get_info_about_user(team_id: team_id,
    #                                                    user_id: user_id)
    responds = GatherRespondsFromMorning.call( action[:payload][:state][:values])
    # pp action[:payload][:state][:values]

    Faraday.post(action[:payload][:response_url], {
      text: "Dzięki za przeslanie",
      response_type: 'ephemeral'
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }

    date_now = Date.today
    standup = Standup_Check.find_by(user_id: user_id,
                                    date_of_stand: date_now,
                                    team: team_id)
    # responds = []

    if standup.nil?
      Standup_Check.create(
        team: team_id,
        user_id: user_id,
        morning_stand: true,
        date_of_stand: date_now,
        # ts_of_message_morning: ts_message,
        channel_of_message_morning: channel_id,
        morning_first: responds[:first_input],
        morning_second: responds[:second_input],
        morning_third: responds[:second_input],
        morning_fourth: responds[:third_input],
        open_for_pp: responds[:fourth_input],
        is_stationary: responds[:radio_button],
        )
    end
  end
end
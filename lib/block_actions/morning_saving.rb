SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'morning_saving' do |action|
    user_id = action[:payload][:user][:id]
    channel_id = action[:payload][:container][:channel_id]
    team_id = action[:payload][:user][:team_id]

    slack_client = GetSlackClient.call(team_id: team_id)
    name, pic = GetUserNameAndPicture.call(team_id: team_id, user_id: user_id)

    responds = GatherRespondsFromMorning.call( action[:payload][:state][:values])

    Faraday.post(action[:payload][:response_url], {
      text: "Dzięki za przeslanie",
      response_type: 'ephemeral'
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }

    date_now = Date.today
    standup = Standup_Check.find_by(user_id: user_id,
                                    date_of_stand: date_now,
                                    team: team_id)

    create_new_object_in_database = standup.nil?
    create_new_post_in_slack = if standup&.morning_stand
                                 false
                               else
                                 true
                               end

    ts_message = if create_new_post_in_slack
                   MorningStandup.post_new(slack_client: slack_client,
                                           channel_id: channel_id,
                                           text_for_header: "Poranny Standup: #{name}",
                                           pic: pic,
                                           responds: responds)[:ts]
                 else
                   MorningStandup.edit(ts: standup.ts_of_message_morning,
                                       slack_client: slack_client,
                                       channel_id: channel_id,
                                       text_for_header: "Poranny Standup: #{name}",
                                       pic: pic,
                                       responds: responds)[:ts]
                 end

    if create_new_object_in_database
      Standup_Check.create!(
        team: team_id,
        user_id: user_id,
        morning_stand: true,
        date_of_stand: date_now,
        ts_of_message_morning: ts_message,
        channel_of_message_morning: channel_id,
        morning_first: responds[:first_input],
        morning_second: responds[:second_input],
        morning_third: responds[:second_input],
        morning_fourth: responds[:third_input],
        open_for_pp: responds[:fourth_input],
        is_stationary: responds[:radio_button],
        )
    else
      standup.update!(
        team: team_id,
        user_id: user_id,
        morning_stand: true,
        date_of_stand: date_now,
        ts_of_message_morning: ts_message,
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

SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'evening_deleting_and_saving' do |action|
    user_id = action[:payload][:user][:id]
    channel_id = action[:payload][:container][:channel_id]
    team_id = action[:payload][:user][:team_id]

    slack_client = GetSlackClient.call(team_id: team_id)
    name, pic = GetUserNameAndPicture.call(team_id: team_id, user_id: user_id)

    responds = GatherRespondsFromEvening.call( action[:payload][:state][:values])

    date_now = Date.today
    standup = Standup_Check.find_by(user_id: user_id,
                                    date_of_stand: date_now,
                                    team: team_id)

    slack_client.chat_delete(channel: channel_id,
                             ts: standup.ts_of_message_morning)

    ts_message = EveningStandup.post_or_edit(slack_client: slack_client,
                                             channel_id: channel_id,
                                             text_for_header: "Poranny Standup: #{name}",
                                             pic: pic,
                                             responds: responds,
                                             username: name)[:ts]

    standup.update!(
      team: team_id,
      user_id: user_id,
      morning_stand: true,
      date_of_stand: date_now,
      ts_of_message_morning: ts_message,
      channel_of_message_morning: channel_id,
      morning_first: responds[:first_input],
      morning_second: responds[:second_input],
      morning_third: responds[:third_input],
      morning_fourth: responds[:fourth_input],
      open_for_pp: responds[:open_for_pp],
      is_stationary: responds[:place],
    )

    HideMessage.call(action[:payload][:response_url])
  end
end

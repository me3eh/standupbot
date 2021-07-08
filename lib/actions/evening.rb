SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'actionId-1' do |action|
    action_payload = action[:payload]
    arguments_from_form = action_payload[:state][:values]
    action_team = action_payload[:user][:team_id]
    action_userID = action_payload[:user][:id]
    action_channelID = action_payload[:container][:channel_id]

    Faraday.post(action_payload[:response_url], {
      text: "Dzięki za przeslanie",
      response_type: 'ephemeral'
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }
    responds = []
    arguments_from_form.each do |u|
      responds.append u[1][:input][:value].nil? ?
        ":ultrafast_serin_spiner:" :
        u[1][:input][:value]
    end

    team = Team.find_by(team_id: action_team) ||
      raise("Cannot find team with ID #{action_team}.")

    slack_client = Slack::Web::Client.new(token: team.token)
    pic = slack_client.users_info(user: action_userID)[:user][:profile][:image_192]

    ts_message = post_public(
      slack_client: slack_client,
      command_channel: action_channelID,
      name_of_user: slack_client.users_info(user: action_userID)[:user][:profile][:real_name],
      word: responds, pic: pic)[:ts]

    date_now = Date.today
    standup = Standup_Check.find_by(user_id: action_userID,
                                    date_of_stand: date_now,
                                    team: team.team_id)
    if standup.nil?
      Standup_Check.create(
        team: team.team_id, user_id: action_userID,
        evening_stand: true, date_of_stand: date_now,
        ts_of_message_evening: ts_message,
        channel_of_message_evening: action_channelID)
    elsif !standup.evening_stand
        standup.update(evening_stand: true, ts_of_message_evening: ts_message,
                       channel_of_message_evening: action_channelID)
    elsif standup.evening_stand
      slack_client.chat_delete(channel: standup.channel_of_message_evening,
                               ts: standup.ts_of_message_evening)
      standup.update(ts_of_message_evening: ts_message,
                     channel_of_message_evening: action_channelID)
    end
  end
end
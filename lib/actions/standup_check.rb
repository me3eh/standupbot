SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'actionId-2' do |action1|
    action_payload = action1[:payload]
    channel_id = action_payload[:container][:channel_id]
    user_id = action_payload[:user][:id]
    team = Team.find_by(team_id: action_payload[:user][:team_id].to_s) ||
      raise("Cannot find team with ID #{action_payload[:user][:team_id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)

    Faraday.post(action_payload[:response_url], {
      text: 'Dzięki za przeslanie',
      "blocks":[
      ],
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }
    hashmap = {}
    users_in_channel = []
    slack_client.conversations_members(channel: channel_id)[:members].each do |u|
      info_about = slack_client.users_info(user: u)[:user]
      hashmap = hashmap.merge({u => info_about[:profile][:real_name]})
      users_in_channel.append(u) unless info_about[:is_bot]
    end

    responses = Array.new(2)
    action_payload[:state][:values].each_with_index do |u, index|
      if index.equal?(0)
        responses[index] = Date.parse u[1][:"datepicker-action"][:selected_date]
      else
        responses[index] = u[1][:action][:selected_options]
      end
    end
    birth_day_of_bot = Date.new(2021, 7, 5)
    date_today = Date.today
    if responses[0] > Date.today || responses[0] < birth_day_of_bot
      incorrect_data(slack_client: slack_client, channel_id: channel_id,
                     command_user: user_id, date: responses[0],
                     birth_date_of_bot: birth_day_of_bot, today: date_today)
    else
      word = []
      word.append(Standup_Check.where(date_of_stand: responses[0],
                                      team: team.team_id,
                                      morning_stand: true).map(&:user_id))
      word.append(Standup_Check.where(date_of_stand: responses[0],
                                      team: team.team_id,
                                      evening_stand: true).map(&:user_id))
      word.append(word[0] & word[1])
      word.append(users_in_channel - word[0] - word[1])
      word.insert(0, word.delete_at(3))
      1.upto 2 do |i|
        word[i] = word[i] - word[3]
      end
      if responses[1].empty?
        word.each_with_index do |w, index|
          list_users_with_activity_private(
            type_of_text: index, slack_client: slack_client,
            command_channel: channel_id, command_user: user_id,
            content_attachment: attachment_content(hashmap: hashmap,
                                                   users: w),
            date: responses[0]) unless w.empty?
        end
      else
        word.each_with_index do |w, index|
          list_users_with_activity_public(
            type_of_text: index, slack_client: slack_client,
            command_channel: channel_id, date: responses[0],
            content_attachment:
              attachment_content(hashmap: hashmap, users: w)) unless w.empty?
        end
      end

    end
  end
end


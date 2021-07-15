SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'actionId-2' do |action1|

    action_payload = action1[:payload]
    Faraday.post(action_payload[:response_url], {
      text: 'Dzięki za przeslanie',
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }
    channel_id = action_payload[:container][:channel_id]
    user_id = action_payload[:user][:id]
    team_id = action_payload[:user][:team_id]
    slack_client = $everything_needed.get_slack_client(team_id: team_id)
    users_in_channel = $everything_needed.get_list_members_in_channel(team_id: team_id, channel_id: channel_id)
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
    if responses[0] > date_today || responses[0] < birth_day_of_bot
      incorrect_data(slack_client: slack_client, channel_id: channel_id,
                     command_user: user_id, date: responses[0],
                     birth_date_of_bot: birth_day_of_bot, today: date_today)
    else
      word = []
      excusal =
        Free_From_Standup.where(
          "date_of_beginning <= ? AND date_of_ending >= ?",
          responses[0],
          responses[0]
        ).map(&:user_id)
      excusal = excusal.uniq
      word.append(
        Standup_Check.where(date_of_stand: responses[0],
                            team: team_id,
                            morning_stand: true).map(&:user_id)
      )
      word.append(
        Standup_Check.where(date_of_stand: responses[0],
                            team: team_id,
                            evening_stand: true).map(&:user_id)
      )
      users_in_channel = users_in_channel - excusal
      word[0] = word[0] - excusal
      word[1] = word[1] - excusal
      word.append(word[0] & word[1])
      word.append(users_in_channel - word[0] - word[1])
      word.insert(0, word.delete_at(3))
      1.upto 2 do |i|
        word[i] = word[i] - word[3]
      end

      word.append excusal
      if responses[1].empty?
        word.each_with_index do |w, index|
          list_users_private(
            type_of_text: index,
            slack_client: slack_client,
            command_channel: channel_id,
            command_user: user_id,
            date: responses[0],
            content_attachment:
              attachment_content(
                team_id: team_id,
                users: w ) ) unless w.empty?
        end
      else
        word.each_with_index do |w, index|
          list_users_public(
            type_of_text: index,
            slack_client: slack_client,
            command_channel: channel_id,
            date: responses[0],
            content_attachment: attachment_content( team_id: team_id,
                                                    users: w)
          ) unless w.empty?
          #thanks to that, there aren't showing null messages
        end
      end
    end
  end
end


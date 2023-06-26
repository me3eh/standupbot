SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'who_doesnt_standup' do |action1|
    action_payload = action1[:payload]
    channel_id = action_payload[:container][:channel_id]
    user_id = action_payload[:user][:id]
    team_id = action_payload[:user][:team_id]
    slack_client = $everything_needed.get_slack_client(team_id: team_id)
    responses = Array.new(3)

    action_payload[:state][:values].each_with_index do |u, index|
      if index.equal?(0)
        responses[index] = Date.parse u[1][:"datepicker-action"][:selected_date]
      elsif index.equal?(1)
        responses[index] =
          if u[1][:static_select_action][:selected_option].nil?
            0
          else
            u[1][:static_select_action][:selected_option][:value]
          end
      elsif index.equal?(2)
        responses[index] = u[1][:action][:selected_options]
      end
    end
    birth_day_of_bot = Date.new(2021, 7, 5)
    date_today = Date.today
    if responses[0] > date_today || responses[0] < birth_day_of_bot
      incorrect_data(slack_client: slack_client,
                     channel_id: channel_id,
                     command_user: user_id,
                     date: responses[0],
                     birth_date_of_bot: birth_day_of_bot,
                     today: date_today)
    else
      count_of_standup_and_no_standup =
        $everything_needed.get_number_of_standups(date_required: responses[0],
                                                  team_id: team_id,
                                                  channel_id: channel_id)
      if responses[2].empty?
        list_users_private(
          type_of_text: responses[1].to_i,
          response_url: action_payload[:response_url],
          date: responses[0],
          counts: count_of_standup_and_no_standup,
          content_attachment:
            attachment_content(
              team_id: team_id,
              users: count_of_standup_and_no_standup[responses[1].to_i + 5]
            ),
          first: true
        )
      else
        list_users_public(
          type_of_text: responses[1].to_i,
          slack_client: slack_client,
          command_channel: channel_id,
          date: responses[0],
          content_attachment: attachment_content(team_id: team_id,
                                                 users: count_of_standup_and_no_standup[responses[1].to_i + 5])
        )
      end
    end
  end
end

SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'interactive_message', 'who_doesnt_standup' do |action|
    action_payload = action[:payload]
    value_option = action_payload[:actions][0][:value].split('/')
    team_id = action_payload[:team][:id]
    channel_id = action_payload[:channel][:id]
    count_of_standup_and_users_in_them =
      $everything_needed.get_number_of_standups(date_required: value_option[1],
                                              channel_id: channel_id,
                                              team_id: team_id)
    number_of_selection = 0
    case value_option[0]
    when "nothing"
      number_of_selection = 0
    when "only_morning"
      number_of_selection = 1
    when "only_evening"
      number_of_selection = 2
    when "both"
      number_of_selection = 3
    when "excusal"
      number_of_selection = 4
    end
      list_users_private(
        type_of_text: number_of_selection,
        response_url: action_payload[:response_url],
        date: value_option[2],
        counts: count_of_standup_and_users_in_them,
        content_attachment:
          attachment_content(
            team_id: team_id,
            users: count_of_standup_and_users_in_them[number_of_selection + 5]),
        first: false)
  end
end

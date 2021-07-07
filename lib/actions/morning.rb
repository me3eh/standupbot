SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'actionId-0' do |action|
    action_payload = action[:payload]
    arguments_from_form = action_payload[:state][:values]
    action_userID = action_payload[:user][:id]

    team = Team.find_by(team_id: action_payload[:user][:team_id].to_s) ||
      raise("Cannot find team with ID #{action_payload[:user][:team_id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)

    Faraday.post(action_payload[:response_url], {
      text: "Dzięki za przeslanie",
      response_type: 'ephemeral'
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }

    responds = []
    arguments_from_form.each.with_index do |u, index|
      if index != arguments_from_form.size - 1
        responds.append u[1][:input][:value].nil? ?
        ":speak_no_evil:" :
        u[1][:input][:value]
      else
        responds.append u[1][:choice][:selected_option].nil? ?
        "Idk, gdzieś w przestrzeni kosmicznej" :
        u[1][:choice][:selected_option][:text][:text]
      end
    end

    post_public(slack_client: slack_client,
                command_channel: action_payload[:container][:channel_id],
                name_of_user: slack_client.users_info(user: action_userID)[:user][:profile][:real_name],
                word: responds, is_morning: true)

    date_now = Date.today
    standup = Standup_Check.find_by(user_id: action_userID,
                                    date_of_stand: date_now,
                                    team: team.team_id)
    if standup.nil?
      Standup_Check.create(team: team.team_id, user_id: action_userID,
                           morning_stand: true, date_of_stand: date_now)
    elsif !standup.morning_stand
      standup.update(morning_stand: true)
    end
  end
end
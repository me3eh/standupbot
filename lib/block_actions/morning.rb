SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'actionId-0' do |action|
    action_payload = action[:payload]
    arguments_from_form = action_payload[:state][:values]
    user_id = action_payload[:user][:id]
    channel_id = action_payload[:container][:channel_id]
    team = Team.find_by(team_id: action_payload[:user][:team_id].to_s) ||
      raise("Cannot find team with ID #{action_payload[:user][:team_id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)
    pic = slack_client.users_info(user: user_id)[:user][:profile][:image_192]
    Faraday.post(action_payload[:response_url], {
      text: "Dzięki za przeslanie",
      response_type: 'ephemeral'
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }

    responds = []
    arguments_from_form.each.with_index do |u, index|
      if index != arguments_from_form.size - 2 &&
        index != arguments_from_form.size - 1
          responds.append u[1][:input][:value].nil? ?
          ":speak_no_evil:" :
          u[1][:input][:value]
      elsif index == arguments_from_form.size - 2
        responds.append u[1][:actionblank][:selected_options].empty? ?
          false : true
      else
        responds.append u[1][:choice][:selected_option].nil? ?
        "Idk, gdzieś w przestrzeni kosmicznej" :
        u[1][:choice][:selected_option][:text][:text]
      end
    end

    ts_message = post_public_morning(
      slack_client: slack_client,
      command_channel: channel_id,
      name_of_user: slack_client.users_info(user: user_id)[:user][:profile][:real_name],
      word: responds, pic: pic)[:ts]

    date_now = Date.today
    standup = Standup_Check.find_by(user_id: user_id,
                                    date_of_stand: date_now,
                                    team: team.team_id)
    stationary = responds[5].nil? ? 0 : stationary_or_remotely(responds[5])
    if standup.nil?
      Standup_Check.create(
        team: team.team_id,
        user_id: user_id,
        morning_stand: true,
        date_of_stand: date_now,
        ts_of_message_morning: ts_message,
        channel_of_message_morning: channel_id,
        morning_first: responds[0],
        morning_second: responds[1],
        morning_third: responds[2],
        morning_fourth: responds[3],
        open_for_pp: responds[4],
        is_stationary: stationary
      )

    elsif !standup.morning_stand
      standup.update(
        morning_stand: true,
        ts_of_message_morning: ts_message,
        channel_of_message_morning: channel_id,
        morning_first: responds[0],
        morning_second: responds[1],
        morning_third: responds[2],
        morning_fourth: responds[3],
        open_for_pp: responds[4],
        is_stationary: stationary
      )
    elsif standup.morning_stand
      slack_client.chat_delete(channel: standup.channel_of_message_morning,
                               ts: standup.ts_of_message_morning)
      standup.update(
        ts_of_message_morning: ts_message,
        channel_of_message_morning: channel_id,
        morning_first: responds[0],
        morning_second: responds[1],
        morning_third: responds[2],
        morning_fourth: responds[3],
        open_for_pp: responds[4],
        is_stationary: stationary
      )
    end
  end
end

def stationary_or_remotely(choice)
  choice.eql?("Stacjonarnie") ? 1 : 2
end
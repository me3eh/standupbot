SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'actionId-1' do |action|
    include Keeper_post_standup
    action_payload = action[:payload]
    arguments_from_form = action_payload[:state][:values]
    team_id = action_payload[:user][:team_id]
    user_id = action_payload[:user][:id]
    channel_id = action_payload[:container][:channel_id]
    slack_client = $everything_needed.get_slack_client(team_id: team_id)
    name, pic = $everything_needed.get_info_about_user(team_id: team_id,
                                                       user_id: user_id)

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

    ts_message = Keeper_post_standup.post_public_evening(
      slack_client: slack_client,
      command_channel: channel_id,
      name_of_user: name,
      word: responds, pic: pic)[:ts]

    date_now = Date.today
    standup = Standup_Check.find_by(user_id: user_id,
                                    date_of_stand: date_now,
                                    team: team_id)
    if standup.nil?
      Standup_Check.create(
        team: team_id,
        user_id: user_id,
        evening_stand: true,
        date_of_stand: date_now,
        ts_of_message_evening: ts_message,
        channel_of_message_evening: channel_id,
        evening_first: responds[0],
        evening_second: responds[1],
        evening_third: responds[2],
        evening_fourth: responds[3],
        PRs_and_estimation: responds[4]
      )
    elsif !standup.evening_stand
        standup.update(evening_stand: true,
                       ts_of_message_evening: ts_message,
                       channel_of_message_evening: channel_id,
                       evening_first: responds[0],
                       evening_second: responds[1],
                       evening_third: responds[2],
                       evening_fourth: responds[3],
                       PRs_and_estimation: responds[4]
        )
    elsif standup.evening_stand
      slack_client.chat_delete(channel: standup.channel_of_message_evening,
                               ts: standup.ts_of_message_evening
      )
      standup.update(ts_of_message_evening: ts_message,
                     channel_of_message_evening: channel_id,
                     evening_first: responds[0],
                     evening_second: responds[1],
                     evening_third: responds[2],
                     evening_fourth: responds[3],
                     PRs_and_estimation: responds[4]
      )
    end
  end
end
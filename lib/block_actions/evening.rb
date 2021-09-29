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
    date_now = Date.today
    standup = Standup_Check.find_by(user_id: user_id,
                                    date_of_stand: date_now,
                                    team: team_id)
    creating_standup = standup.nil? ? true : !standup.evening_stand
    value_1_if_editing_existing_standup = creating_standup ? 0 : 1

    Faraday.post(action_payload[:response_url], {
      text: "Dzięki za przeslanie",
      response_type: 'ephemeral'
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }
    responds = []
    gathering_responds_from_form_evening(responds: responds,
                                 arguments_from_form: arguments_from_form,
                                 creating_standup: creating_standup)

    if (responds[0] == 'delete-and-create' && !creating_standup) || creating_standup
      ts_message = post_public_evening(slack_client: slack_client,
                                       command_channel: channel_id,
                                       name_of_user: name,
                                       word: responds,
                                       pic: pic,
                                       value_1_if_editing_existing_standup: value_1_if_editing_existing_standup)[:ts]
    end

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
    elsif standup.evening_stand
      if responds[0] == 'delete-and-create'
        slack_client.chat_delete(channel: standup.channel_of_message_evening,
                               ts: standup.ts_of_message_evening)
        standup.update(ts_of_message_evening: ts_message,
                       channel_of_message_evening: channel_id,
                       evening_first: responds[1],
                       evening_second: responds[2],
                       evening_third: responds[3],
                       evening_fourth: responds[4],
                       PRs_and_estimation: responds[5])
      else
        edit_public_evening(slack_client: slack_client,
                            command_channel: channel_id,
                            name_of_user: name,
                            word: responds,
                            pic: pic,
                            ts: standup.ts_of_message_evening,
                            value_1_if_editing_existing_standup: value_1_if_editing_existing_standup)
      end
    elsif !standup.evening_stand
      standup.update(evening_stand: true,
                     ts_of_message_evening: ts_message,
                     channel_of_message_evening: channel_id,
                     evening_first: responds[0],
                     evening_second: responds[1],
                     evening_third: responds[2],
                     evening_fourth: responds[3],
                     PRs_and_estimation: responds[4])
    end
  end
end
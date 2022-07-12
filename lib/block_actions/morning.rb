SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'actionId-0' do |action|
    # include Keeper_post_standup
    #
    # action_payload = action[:payload]
    # arguments_from_form = action_payload[:state][:values]
    # user_id = action_payload[:user][:id]
    # channel_id = action_payload[:container][:channel_id]
    # team_id = action_payload[:user][:team_id]
    # slack_client = $everything_needed.get_slack_client(team_id: team_id)
    # name, pic = $everything_needed.get_info_about_user(team_id: team_id,
    #                                                    user_id: user_id)
    # pp GatherRespondsFromMorning.call(action[:payload][:state][:values])
    pp action[:payload][:state][:values]

    Faraday.post(action[:payload][:response_url], {
      text: "Dzięki za przeslanie",
      response_type: 'ephemeral'
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }
    # date_now = Date.today
    # standup = Standup_Check.find_by(user_id: user_id,
    #                                 date_of_stand: date_now,
    #                                 team: team_id)
    # responds = []
    #
    # creating_standup = standup.nil? ? true : !standup.morning_stand
    # value_1_if_editing_existing_standup = creating_standup ? 0 : 1
    #
    # gathering_responds_from_form_morning(responds: responds,
    #                              arguments_from_form: arguments_from_form,
    #                              creating_standup: creating_standup)
    #
    # #responds[0] will tell in which state [edit/delete-and-create]
    # # will be the standup if there was before an existing one
    #
    # if (responds[0] == 'delete-and-create' && !creating_standup) || creating_standup
    #   ts_message = post_public_morning( slack_client: slack_client,
    #                                   command_channel: channel_id,
    #                                   name_of_user: name,
    #                                   word: responds,
    #                                   pic: pic,
    #                                   value_1_if_editing_existing_standup: value_1_if_editing_existing_standup)[:ts]
    # end
    # stationary = responds[5 + value_1_if_editing_existing_standup].eql?("Idk, gdzieś w przestrzeni kosmicznej") ?
    #                0 : stationary_or_remotely(responds[5 + value_1_if_editing_existing_standup])
    #
    # if standup.nil?
    #   Standup_Check.create(
    #     team: team_id,
    #     user_id: user_id,
    #     morning_stand: true,
    #     date_of_stand: date_now,
    #     ts_of_message_morning: ts_message,
    #     channel_of_message_morning: channel_id,
    #     morning_first: responds[0],
    #     morning_second: responds[1],
    #     morning_third: responds[2],
    #     morning_fourth: responds[3],
    #     open_for_pp: responds[4],
    #     is_stationary: stationary
    #   )
    # elsif standup.morning_stand
    #   if responds[0] == 'delete-and-create'
    #     slack_client.chat_delete(
    #       channel: standup.channel_of_message_morning,
    #       ts: standup.ts_of_message_morning
    #     )
    #     standup.update(
    #       ts_of_message_morning: ts_message,
    #       channel_of_message_morning: channel_id,
    #       morning_first: responds[1],
    #       morning_second: responds[2],
    #       morning_third: responds[3],
    #       morning_fourth: responds[4],
    #       open_for_pp: responds[5],
    #       is_stationary: stationary
    #     )
    #   else
    #     edit_public_morning(slack_client: slack_client,
    #                         ts: standup.ts_of_message_morning,
    #                         name_of_user: name,
    #                         command_channel: standup.channel_of_message_morning,
    #                         word: responds,
    #                         pic: pic,
    #                         value_1_if_editing_existing_standup: value_1_if_editing_existing_standup)
    #     # slack_client.chat_update(
    #     #   channel: standup.channel_of_message_morning,
    #     #   ts: standup.ts_of_message_morning,
    #     #   attachments: [
    #     #     {
    #     #       "title": "4. Kompan do pomocy?",
    #     #       "value": "dupa",
    #     #       "short": false
    #     #     },
    #     #   ]
    #     # )
    #     standup.update(
    #       channel_of_message_morning: channel_id,
    #       morning_first: responds[1],
    #       morning_second: responds[2],
    #       morning_third: responds[3],
    #       morning_fourth: responds[4],
    #       open_for_pp: responds[5],
    #       is_stationary: stationary
    #     )
    #   end
    #
    # elsif !standup.morning_stand
    #   standup.update(
    #     morning_stand: true,
    #     ts_of_message_morning: ts_message,
    #     channel_of_message_morning: channel_id,
    #     morning_first: responds[0],
    #     morning_second: responds[1],
    #     morning_third: responds[2],
    #     morning_fourth: responds[3],
    #     open_for_pp: responds[4],
    #     is_stationary: stationary
    #   )
    # end
  end
end

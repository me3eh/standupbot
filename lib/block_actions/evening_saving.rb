SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'evening_saving' do |action|
    # include Keeper_post_standup
    # action_payload = action[:payload]
    # arguments_from_form = action_payload[:state][:values]
    # team_id = action_payload[:user][:team_id]
    # user_id = action_payload[:user][:id]
    # channel_id = action_payload[:container][:channel_id]
    # slack_client = $everything_needed.get_slack_client(team_id: team_id)
    # name, pic = $everything_needed.get_info_about_user(team_id: team_id,
    #                                                    user_id: user_id)
    # date_now = Date.today
    # standup = Standup_Check.find_by(user_id: user_id,
    #                                 date_of_stand: date_now,
    #                                 team: team_id)
    # creating_standup = standup.nil? ? true : !standup.evening_stand
    # value_1_if_editing_existing_standup = creating_standup ? 0 : 1
    #
    # Faraday.post(action_payload[:response_url], {
    #   text: "Dzięki za przeslanie",
    #   response_type: 'ephemeral'
    # }.to_json, 'Content-Type' => 'application/json')
    # { ok: true }
    # responds = []
    # gathering_responds_from_form_evening(responds: responds,
    #                              arguments_from_form: arguments_from_form,
    #                              creating_standup: creating_standup)
    #
    # if (responds[0] == 'delete-and-create' && !creating_standup) || creating_standup
    #   ts_message = post_public_evening(slack_client: slack_client,
    #                                    command_channel: channel_id,
    #                                    name_of_user: name,
    #                                    word: responds,
    #                                    pic: pic,
    #                                    value_1_if_editing_existing_standup: value_1_if_editing_existing_standup)[:ts]
    # end
    #
    # if standup.nil?
    #   Standup_Check.create(
    #     team: team_id,
    #     user_id: user_id,
    #     evening_stand: true,
    #     date_of_stand: date_now,
    #     ts_of_message_evening: ts_message,
    #     channel_of_message_evening: channel_id,
    #     evening_first: responds[0],
    #     evening_second: responds[1],
    #     evening_third: responds[2],
    #     evening_fourth: responds[3],
    #     PRs_and_estimation: responds[4]
    #   )
    # elsif standup.evening_stand
    #   if responds[0] == 'delete-and-create'
    #     slack_client.chat_delete(channel: standup.channel_of_message_evening,
    #                            ts: standup.ts_of_message_evening)
    #     standup.update(ts_of_message_evening: ts_message,
    #                    channel_of_message_evening: channel_id,
    #                    evening_first: responds[1],
    #                    evening_second: responds[2],
    #                    evening_third: responds[3],
    #                    evening_fourth: responds[4],
    #                    PRs_and_estimation: responds[5])
    #   else
    #     edit_public_evening(slack_client: slack_client,
    #                         command_channel: channel_id,
    #                         name_of_user: name,
    #                         word: responds,
    #                         pic: pic,
    #                         ts: standup.ts_of_message_evening,
    #                         value_1_if_editing_existing_standup: value_1_if_editing_existing_standup)
    #   end
    # elsif !standup.evening_stand
    #   standup.update(evening_stand: true,
    #                  ts_of_message_evening: ts_message,
    #                  channel_of_message_evening: channel_id,
    #                  evening_first: responds[0],
    #                  evening_second: responds[1],
    #                  evening_third: responds[2],
    #                  evening_fourth: responds[3],
    #                  PRs_and_estimation: responds[4])
    # end
    user_id = action[:payload][:user][:id]
    channel_id = action[:payload][:container][:channel_id]
    team_id = action[:payload][:user][:team_id]

    slack_client = GetSlackClient.call(team_id: team_id)
    name, pic = GetUserNameAndPicture.call(team_id: team_id, user_id: user_id)

    responds = GatherRespondsFromEvening.call( action[:payload][:state][:values])

    Faraday.post(action[:payload][:response_url], {
      text: "Wszystko oki"
    }.to_json, 'Content-Type' => 'application/json')

    date_now = Date.today
    standup = Standup_Check.find_by(user_id: user_id,
                                    date_of_stand: date_now,
                                    team: team_id)

    create_new_object_in_database = standup.nil?

    ts_message = EveningStandup.post_or_edit(ts: standup&.ts_of_message_evening,
                                             slack_client: slack_client,
                                             channel_id: channel_id,
                                             text_for_header: "Poranny Standup: #{name}",
                                             pic: pic,
                                             responds: responds,
                                             username: name)[:ts]

    if create_new_object_in_database
      Standup_Check.create!(
        team: team_id,
        user_id: user_id,
        evening_stand: true,
        date_of_stand: date_now,
        ts_of_message_evening: ts_message,
        channel_of_message_evening: channel_id,
        evening_first: responds[:first_input],
        evening_second: responds[:second_input],
        evening_third: responds[:third_input],
        evening_fourth: responds[:fourth_input],
        PrsAnd: responds[:prs],
        )
    else
      standup.update!(
        team: team_id,
        user_id: user_id,
        morning_stand: true,
        date_of_stand: date_now,
        ts_of_message_morning: ts_message,
        channel_of_message_morning: channel_id,
        morning_first: responds[:first_input],
        morning_second: responds[:second_input],
        morning_third: responds[:third_input],
        morning_fourth: responds[:fourth_input],
        open_for_pp: responds[:open_for_pp],
        is_stationary: responds[:place],
        )
    end
  end
end
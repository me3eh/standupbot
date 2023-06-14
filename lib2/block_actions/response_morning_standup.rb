SlackRubyBotServer::Events.configure do |config|
    config.on :action, 'block_actions', 'morning_saving' do |params|

        user_id= params.dig(:payload, :user, :id)
        channel_id= params.dig(:payload, :container, :channel_id)
        team_id = params.dig(:payload, :user, :team_id)
        
        slack_client = Services::GetSlackClient.call(team_id: team_id)
        name, pic = Services::GetUserNameAndPicture.call(team_id: team_id, user_id: user_id)
        responds = Services::GatherRespondsFromMorning.new(params).call

        date_now=Date.today
        ts=params.dig(:payload,:container, :message_ts)
        
        morning_standup = Services::MorningStandup.new
        ts_message = morning_standup.post(ts: ts, slack_client: slack_client, channel_id: channel_id, text_for_header: "Poranny standup!", pic: pic, responds: responds, username: name)[:ts]
        

        create_new_object_in_database= StandupCheck.create!(
            team: team_id,
            user_id: user_id,
            morning_standup: true,
            date_of_stand: date_now,
            ts_of_message_morning: ts_message,
            channel_of_message_morning: channel_id,
            morning_first: responds[:first_input],
            morning_second: responds[:second_input],
            morning_third: responds[:third_input],
            morning_fourth: responds[:fourth_input],
            morning_fifth: responds[:fifth_input],
            morning_sixth: responds[:sixth_input],
            morning_seventh: responds[:seventh_input],
            morning_eighth: responds[:eighth_input],
            place: responds[:place],
            open_for_PP: responds[:open_for_pp]
        )

        HideMessage.call(action[:payload][:response_url])

    end
end
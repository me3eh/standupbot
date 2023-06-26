SlackRubyBotServer::Events.configure do |config|
    config.on :action, 'message_action', 'edit_standup' do |params|
      ts_message = params.dig(:payload, :message, :ts)
      user_id = params.dig(:payload, :user, :id)
      team_id = params.dig(:payload, :team, :id)
      channel_id = params.dig(:payload, :channel, :id)
      slack_client = Services::GetSlackClient.call(team_id: team_id)

    

      standup = StandupCheck.where(user_id: user_id, team: team_id)
          .find_by("ts_of_message_morning = ? OR ts_of_message_evening = ?", ts_message,ts_message)
  
      json_blocks = if params.dig(:payload, :message, :attachments).first.dig(:fields).size == 8
        Jsons::FilledMorningForm.new.call(user_id: user_id, team_id: team_id, standup: standup)
      else
        Jsons::FilledEveningForm.new.call(user_id: user_id, team_id: team_id, standup: standup)
      end

      username, pic = Services::GetUserNameAndPicture.call(team_id: team_id, user_id: user_id)

      slack_client.chat_postMessage(
        channel: channel_id,
        blocks: json_blocks,
        icon_url: pic,
        username: username
      )

      # standup = StandupCheck.find_by(ts_of_message_evening: ts_message, user_id: user, team: team) if standup.nil?
  
  
      # Faraday.post(action[:payload][:response_url], {
      #   response_type: 'ephemeral',
      #   "blocks":[
      #     {
      #       "type": "section",
      #       "text": {
      #         "type": "mrkdwn",
      #         "text": ":serin: Rozwiń załącznik  :nires:"
      #       }
      #     },
      #     {
      #       "type": "image",
      #       "image_url": "https://cdn.discordapp.com/attachments/766045866724163647/862998404031578112/ezgif.com-gif-maker4.gif",
      #       "alt_text": "inspiration"
      #     }
      #   ],
      # }.to_json, 'Content-Type' => 'application/json')
    #   { ok: true }
    end
  end
SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'message_action', 'edit_standup' do |params|
    ts_message = params.dig(:payload, :message, :ts)
    user_id = params.dig(:payload, :user, :id)
    team_id = params.dig(:payload, :team, :id)
    channel_id = params.dig(:payload, :channel, :id)
    slack_client = Services::GetSlackClient.call(team_id: team_id)
    username, pic = Services::GetUserNameAndPicture.call(team_id: team_id, user_id: user_id)

    standup = StandupCheck.where(user_id: user_id, team: team_id)
                          .find_by('ts_of_message_morning = ? OR ts_of_message_evening = ?', ts_message, ts_message)

    if standup.nil?
      slack_client.chat_postEphemeral(
        user: user_id,
        channel: channel_id,
        text: 'A co to za edytowanie nieswojego standupu?!. Nieladnie. Sobie jeszcze ziazie zrobisz, i co będzie?',
        icon_url: pic,
        username: username
      )
    else
      standup_buffer = StandupBuffer.find_by(user_id: user_id, team_id: team_id)
      if standup_buffer.nil?
        StandupBuffer.create(user_id: user_id, team_id: team_id, message_timestamp: ts_message)
      else
        standup_buffer.update!(message_timestamp: ts_message)
      end


      json_blocks = if params.dig(:payload, :message, :attachments).first.dig(:fields).size >= 8
                      Jsons::FilledMorningForm.new.call(user_id: user_id, team_id: team_id, standup: standup)
                    else
                      Jsons::FilledEveningForm.new.call(user_id: user_id, team_id: team_id, standup: standup)
                    end

      slack_client.chat_postEphemeral(
        user: user_id,
        channel: channel_id,
        blocks: json_blocks,
        icon_url: pic,
        username: username
      )
    end

    { ok: true }
  end
end

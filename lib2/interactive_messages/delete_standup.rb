# frozen_string_literal: true
#
SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'message_action', 'delete_standup' do |params|
    ts_message = params.dig(:payload, :message, :ts)
    user_id = params.dig(:payload, :user, :id)
    team_id = params.dig(:payload, :team, :id)
    channel_id = params.dig(:payload, :channel, :id)
    slack_client = Services::GetSlackClient.call(team_id: team_id)

    standup = StandupCheck.where(user_id: user_id, team: team_id)
                          .find_by('ts_of_message_morning = ? OR ts_of_message_evening = ?', ts_message, ts_message)
    if standup.nil?
      slack_client.chat_postEphemeral(
        user: user_id,
        channel: channel_id,
        text: 'A co to za edytowanie nieswojego standupu?!. Nieladnie. Sobie jeszcze ziazie zrobisz, i co będzie?',
      )
    else
      standup.delete!

      slack_client.chat_delete(
        channel: channel_id,
        ts: ts_message
      )
    end
  end
end

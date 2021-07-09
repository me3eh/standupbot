SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/who_doesnt_standup' do |command|
    team = Team.find_by(team_id: command[:team_id]) ||
      raise("Cannot find team with ID #{command[:team_id]}.")

    slack_client = Slack::Web::Client.new(token: team.token)
    today_now = Date.today
    slack_client.chat_postEphemeral(
      channel: command[:channel_id],
      user: command[:user_id],
      "blocks": [
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": "Wybierz date, dla której byś chciał wyświetlić listę"
          },
          "accessory": {
            "type": "datepicker",
            "initial_date": "#{today_now}",
            "placeholder": {
              "type": "plain_text",
              "text": "Select a date",
              "emoji": true
            },
            "action_id": "datepicker-action"
          }
        },
        {
          "type": "actions",
          "elements": [
            {
              "type": "checkboxes",
              "options": [
                {
                  "text": {
                    "type": "mrkdwn",
                    "text": "*Czy chcesz, by twoja komenda została wyświetlona dla wszystkich?*"
                  },
                  "description": {
                    "type": "mrkdwn",
                    "text": "P.S. Nie chcesz tego"
                  },
                  "value": "value-2"
                }
              ],
              "action_id": "action"
            }
          ]
        },
        {
          "type": "actions",
          "elements": [
            {
              "type": "button",
              "text": {
                "type": "plain_text",
                "text": "Click Me",
                "emoji": true
              },
              "value": "click_me_123",
              "action_id": "actionId-2"
            }
          ]
        }
      ],
      )
    {text: ":slow_parrot: :fast_parrot: Ktoś w końcu uruchomił tę komendę :ultra_fast_parot: :light_fast_parrot:"}
  end
end
# MORNING_NOTIFICATION = "1. Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?\n\n"+
#   "2. Jakie widzisz zagrożenia i blockery w powyższej liście?\n\n"+
#   "3. Czy w któryms z powyższych tematów chciałbyś otrzymać pomoc?\n\n"+
#   "4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu"+
#   " konsultacji / podzielenia się wiedzą doświadczeniami ?\n"

SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/morning_standup' do |command|
    team = Team.find_by(team_id: command[:team_id].to_s) || raise("Cannot find team with ID #{command[:team_id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)

    slack_client.chat_postEphemeral(
      channel: command[:channel_id],
      user: command[:user_id],
      "type": "modal",
      "blocks": [
        {
          "type": "header",
          "text": {
            "type": "plain_text",
            "text": "Poranny Standup",
            "emoji": true
          }
        },
        {
          "type": "input",
          "element": {
            "type": "plain_text_input",
            "multiline": true,

            "action_id": "input"
          },
          "label": {
            "type": "plain_text",
            "text": "1. Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?",
            "emoji": true
          },
        },
        {
          "type": "divider"
        },
        {
          "type": "divider"
        },
        {
          "type": "input",
          "element": {
            "type": "plain_text_input",
            "multiline": true,
            "action_id": "input"
          },
          "label": {
            "type": "plain_text",
            "text": "2. Jakie widzisz zagrożenia i blockery w powyższej liście?",
            "emoji": true
          }
        },
        {
          "type": "divider"
        },
        {
          "type": "divider"
        },
        {
          "type": "input",
          "element": {
            "type": "plain_text_input",
            "multiline": true,
            "action_id": "input"
          },
          "label": {
            "type": "plain_text",
            "text": "3. Czy w któryms z powyższych tematów chciałbyś otrzymać pomoc?",
            "emoji": true
          }
        },
        {
          "type": "divider"
        },
        {
          "type": "divider"
        },
        {
          "type": "input",
          "element": {
            "type": "plain_text_input",
            "multiline": true,
            "action_id": "input"
          },
          "label": {
            "type": "plain_text",
            "text": "4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu / konsultacji / podzielenia się wiedzą doświadczeniami ?",
            "emoji": true
          }
        },
        {
          "type": "actions",
          "elements": [
            {
              "type": "radio_buttons",
              "options": [
                {
                  "text": {
                    "type": "plain_text",
                    "text": "Stacjonarnie",
                    "emoji": true
                  },
                  "value": "stationary"
                },
                {
                  "text": {
                    "type": "plain_text",
                    "text": "Zdalnie",
                    "emoji": true
                  },
                  "value": "remotely"
                }
              ],
              "action_id": "choice"
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
                "text": "Potwierdź",
                "emoji": true
              },
              "value": "click_me_123",
              "action_id": "actionId-0"
            }
          ]
        }
        ]
      )
    {text: "Mood_check:\n"+"https://theuselessweb.com/"}
  end
end

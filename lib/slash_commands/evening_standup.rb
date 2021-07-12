

SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/evening_standup' do |command|
    team = Team.find_by(team_id: command[:team_id].to_s) ||
      raise("Cannot find team with ID #{command[:team_id]}.")

    slack_client = Slack::Web::Client.new(token: team.token)
    slack_client.chat_postEphemeral(
      channel: command[:channel_id],
      user: command[:user_id],
      "blocks": [
        {
          "type": "header",
          "text": {
            "type": "plain_text",
            "text": "Wieczorny Standup",
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
            "text": "1. Co udało ci sie dzisiaj skończyć?",
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
            "text": "2. Które zadań nie zostały zakończone i na jakim etapie dzisiaj "+
              "je pozostawiasz ? (pamiętałeś żeby wypchnąć je do repo?)",
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
            "text": "3. Pojawiły się jakieś blockery?",
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
            "text": "4. Czego nowego się dziś nauczyłeś / dowiedziałeś?"+
              "A jeśli niczego to czego w danym temacie chciałbyś się +"+
              "dowiedzieć ? Daj nam sobie pomóc",
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
            "text": "Tutaj wrzuć swoje tickety/pry oraz czas ich wykonania - spokojnie, opcjonalne",
            "emoji": true
          }
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
              "action_id": "actionId-1"
            }
          ]
        }
      ]
    )
    {text: "Mood check\n"+
      'https://media.discordapp.net/attachments/698625741289685222/'+
          '833280278537437214/image0_5.gif'}
  end
end

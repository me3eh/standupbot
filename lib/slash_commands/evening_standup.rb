

SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/evening_standup' do |command|
    team = Team.find_by(team_id: command[:team_id].to_s) ||
      raise("Cannot find team with ID #{command[:team_id]}.")

    slack_client = Slack::Web::Client.new(token: team.token)
    standup = Standup_Check.find_by(user_id: command[:user_id],
                                    date_of_stand: Date.today,
                                    team: command[:team_id])
    json_blocks = get_json_evening

    if !standup.nil? && standup.evening_stand
      standup_containing_initial = [
        standup.evening_first,
        standup.evening_second,
        standup.evening_third,
        standup.evening_fourth,
        standup.PRs_and_estimation
      ]
      0.upto(4) do |numbers|
        json_blocks[numbers*3+1][:element] =
          json_blocks[numbers*3+1][:element].merge(
            {
              "initial_value": standup_containing_initial[numbers]
            }
          )
      end
    end
    slack_client.chat_postEphemeral(
      channel: command[:channel_id],
      user: command[:user_id],
      "blocks": json_blocks)
    {text: "Mood check\n"+
      'https://media.discordapp.net/attachments/698625741289685222/'+
          '833280278537437214/image0_5.gif'}
  end
end

def get_json_evening
  [
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
end

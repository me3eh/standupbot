module Evening_Standup_Commands
  def gathering_responds_from_form_evening(responds:,
                                   arguments_from_form:,
                                   creating_standup: )
    arguments_from_form.each_with_index do |u, index|
      if !creating_standup && first_argument(index)
        responds.append( u[1][:edit_option][:selected_option][:value])
      else
        responds.append u[1][:input][:value].nil? ? ":clown_face:" : u[1][:input][:value]
      end
    end
  end
  def post_public_evening(slack_client:,
                          command_channel:,
                          name_of_user:,
                          word:,
                          pic:,
                          value_1_if_editing_existing_standup:)
    slack_client.chat_postMessage(
      channel: command_channel,
      "blocks": [
        {
          "type": "header",
          "text": {
            "type": "plain_text",
            "text": "Standup wieczorny: "+
              "#{name_of_user}",
            "emoji": true
          }
        },
      ],

      "attachments": [
        fields:[
          {
            "title": "1. Co ukończone?",
            "value": word[0 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "2. Co nieukończone?",
            "value": word[1 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "3. Blockery podczas dnia",
            "value": word[2 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "4. Jakie wnioski?",
            "value": word[3 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "PR'ki, tickeciki itd.",
            "value": word[4 + value_1_if_editing_existing_standup],
            "short": false
          },
        ],
        color: "#1B4D3E",
        thumb_url: "#{pic}",
      ],
      )
  end

  def edit_public_evening(slack_client:,
                          command_channel:,
                          name_of_user:,
                          word:,
                          pic:,
                          ts:,
                          value_1_if_editing_existing_standup:)
    slack_client.chat_update(
      channel: command_channel,
      ts: ts,
      "blocks": [
        {
          "type": "header",
          "text": {
            "type": "plain_text",
            "text": "Standup wieczorny: "+
              "#{name_of_user}",
            "emoji": true
          }
        },
      ],

      "attachments": [
        fields:[
          {
            "title": "1. Co ukończone?",
            "value": word[0 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "2. Co nieukończone?",
            "value": word[1 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "3. Blockery podczas dnia",
            "value": word[2 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "4. Jakie wnioski?",
            "value": word[3 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "PR'ki, tickeciki itd.",
            "value": word[4 + value_1_if_editing_existing_standup],
            "short": false
          },
        ],
        color: "#1B4D3E",
        thumb_url: "#{pic}",
      ],
      )
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

end
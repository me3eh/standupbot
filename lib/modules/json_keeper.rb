module Keeper
  def Keeper.get_json_morning
    [
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
          "action_id": "input",
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
            "type": "checkboxes",
            "options": [
              {
                "text": {
                  "type": "mrkdwn",
                  "text": "*Open for PP*"
                },
                "description": {
                  "type": "mrkdwn",
                  "text": "*Zaznaczenie na własną odpowiedzialność*"
                },
                "value": "value-2"
              }
            ],
            "action_id": "actionblank"
          }
        ]
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
  end

  def Keeper.get_json_evening
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

  def get_initial_check_box__morning
    {
      "initial_options" =>
        [
          {
            "text": {
              "type": "mrkdwn",
              "text": "*Open for PP*"
            },
            "description": {
              "type": "mrkdwn",
              "text": "*Zaznaczenie na własną odpowiedzialność*"
            },
            "value": "value-2"
          }
        ],
    }
  end
end

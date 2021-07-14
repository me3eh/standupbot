# MORNING_NOTIFICATION = "1. Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?\n\n"+
#   "2. Jakie widzisz zagrożenia i blockery w powyższej liście?\n\n"+
#   "3. Czy w któryms z powyższych tematów chciałbyś otrzymać pomoc?\n\n"+
#   "4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu"+
#   " konsultacji / podzielenia się wiedzą doświadczeniami ?\n"

SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/morning_standup' do |command|
    team = Team.find_by(team_id: command[:team_id].to_s) ||
      raise("Cannot find team with ID #{command[:team_id]}.")

    slack_client = Slack::Web::Client.new(token: team.token)
    puts command
    standup = Standup_Check.find_by(user_id: command[:user_id],
                                    date_of_stand: Date.today,
                                    team: command[:team_id])
    puts standup.morning_stand
    json_blocks = get_json_morning
    if !standup.nil? && standup.morning_stand
      # change if adding new blocks
      standup_containing_initial = [
        standup.morning_first,
        standup.morning_second,
        standup.morning_third,
        standup.morning_fourth
      ]
      0.upto(3) do |numbers|
        json_blocks[numbers*3+1][:element] =
          json_blocks[numbers*3+1][:element].merge(
            {
              "initial_value": standup_containing_initial[numbers]
            }
          )
      end

      json_blocks[12][:elements][0] =
        json_blocks[12][:elements][0].merge(get_initial_radio_button(
          is_stationary: standup.is_stationary)
        ) unless standup.is_stationary.equal?(0)

      json_blocks[11][:elements][0] = json_blocks[11][:elements][0].merge(
        get_initial_check_box) if standup.open_for_pp
    end

    slack_client.chat_postEphemeral(
      channel: command[:channel_id],
      user: command[:user_id],
      "blocks": json_blocks
        # [
      #   {
      #     "type": "header",
      #     "text": {
      #       "type": "plain_text",
      #       "text": "Poranny Standup",
      #       "emoji": true
      #     }
      #   },
      #   {
      #     "type": "input",
      #     "element": {
      #       "type": "plain_text_input",
      #       "multiline": true,
      #       "action_id": "input",
      #       # "initial_value": "IDK",
      #   },
      #     "label": {
      #       "type": "plain_text",
      #       "text": "1. Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?",
      #       "emoji": true
      #     },
      #   },
      #   {
      #     "type": "divider"
      #   },
      #   {
      #     "type": "divider"
      #   },
      #   {
      #     "type": "input",
      #     "element": {
      #       "type": "plain_text_input",
      #       "multiline": true,
      #       "action_id": "input"
      #     },
      #     "label": {
      #       "type": "plain_text",
      #       "text": "2. Jakie widzisz zagrożenia i blockery w powyższej liście?",
      #       "emoji": true
      #     }
      #   },
      #   {
      #     "type": "divider"
      #   },
      #   {
      #     "type": "divider"
      #   },
      #   {
      #     "type": "input",
      #     "element": {
      #       "type": "plain_text_input",
      #       "multiline": true,
      #       "action_id": "input"
      #     },
      #     "label": {
      #       "type": "plain_text",
      #       "text": "3. Czy w któryms z powyższych tematów chciałbyś otrzymać pomoc?",
      #       "emoji": true
      #     }
      #   },
      #   {
      #     "type": "divider"
      #   },
      #   {
      #     "type": "divider"
      #   },
      #   {
      #     "type": "input",
      #     "element": {
      #       "type": "plain_text_input",
      #       "multiline": true,
      #       "action_id": "input"
      #     },
      #     "label": {
      #       "type": "plain_text",
      #       "text": "4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu / konsultacji / podzielenia się wiedzą doświadczeniami ?",
      #       "emoji": true
      #     }
      #   },
      #   {
      #     "type": "actions",
      #     "elements": [
      #       {
      #         "type": "checkboxes",
      #         "options": [
      #           {
      #             "text": {
      #               "type": "mrkdwn",
      #               "text": "*Open for PP*"
      #             },
      #             "description": {
      #               "type": "mrkdwn",
      #               "text": "*Zaznaczenie na własną odpowiedzialność*"
      #             },
      #             "value": "value-2"
      #           }
      #         ],
      #         "action_id": "actionblank"
      #       }
      #     ]
      #   },
      #   {
      #     "type": "actions",
      #     "elements": [
      #       {
      #         "type": "radio_buttons",
      #         "options": [
      #           {
      #             "text": {
      #               "type": "plain_text",
      #               "text": "Stacjonarnie",
      #               "emoji": true
      #             },
      #             "value": "stationary"
      #           },
      #           {
      #             "text": {
      #               "type": "plain_text",
      #               "text": "Zdalnie",
      #               "emoji": true
      #             },
      #             "value": "remotely"
      #           }
      #         ],
      #         "action_id": "choice"
      #       }
      #     ]
      #   },
      #   {
      #     "type": "actions",
      #     "elements": [
      #       {
      #         "type": "button",
      #         "text": {
      #           "type": "plain_text",
      #           "text": "Potwierdź",
      #           "emoji": true
      #         },
      #         "value": "click_me_123",
      #         "action_id": "actionId-0"
      #       }
      #     ]
      #   }
      # ]
      )
    {text: "Mood_check:\n"+"https://theuselessweb.com/"}
  end
end

def get_json_morning
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
        # "initial_value": "IDK",
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

def get_initial_check_box
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

def get_initial_radio_button(is_stationary:)
  is_stationary.equal?(1) ?
   {
     "initial_option" => {
       "text": {
        "type": "plain_text",
        "text": "Stacjonarnie",
        "emoji": true
        },
     "value": "stationary"
      }
   } :
   {
     "initial_option" => {
       "text": {
         "type": "plain_text",
         "text": "Zdalnie",
         "emoji": true
       },
       "value": "remotely"
     }
   }
end

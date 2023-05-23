module EveningStandupForm
  class BlankJson
    def initialize
      @first = "1. Co udało ci się dzisiaj skończyć?"
      @second = "2. Co udało ci się dzisiaj skończyć?"
      @third = "3. Pojawiły się jakieś blockery?"
      @fourth = "4. Czego nowego się dziś nauczyłeś / dowiedziałeś ? A jeśli niczego"\
      ", to czego w danym temacie chciałbyś się dowiedzieć ? Daj nam sobie pomóc"
    end

    def call
      {
        "blocks": [
          {
            "type": "header",
            "text": {
              "type": "plain_text",
              "text": "Morning standup",
              "emoji": true
            }
          },
          {
            "type": "divider"
          },
          {
            "type": "input",
            "element": {
              "type": "plain_text_input",
              "multiline": true,
              "action_id": "first_input",
            },
            "label": {
              "type": "plain_text",
              "text": @first,
              "emoji": true
            },
            "block_id": "first_input"
          },
          {
            "type": "input",
            "element": {
              "type": "plain_text_input",
              "multiline": true,
              "action_id": "second_input",
          },
            "label": {
              "type": "plain_text",
              "text": @second,
              "emoji": true
            },
            "block_id": "second_input"
          },
          {
            "type": "input",
            "element": {
              "type": "plain_text_input",
              "multiline": true,
              "action_id": "third_input",
          },
            "label": {
              "type": "plain_text",
              "text": @third,
              "emoji": true
            },
            "block_id": "third_input"
          },
          {
            "type": "input",
            "element": {
              "type": "plain_text_input",
              "multiline": true,
              "action_id": "fourth_input"
            },
            "label": {
              "type": "plain_text",
              "text": @fourth,
              "emoji": true
            },
            "block_id": "fourth_input"
          },
          {
            "type": "context",
            "elements": [
              {
                "type": "mrkdwn",
                "text": "No votes"
              }
            ]
          },
          {
            "type": "divider"
          },
          {
            "type": "actions",
            "elements": [
              {
                "type": "button",
                "text": {
                  "type": "plain_text",
                  "emoji": true,
                  "text": "Create morning standup"
                },
                "value": "submit",
                "action_id": "submit_evening_standup"
              }
            ]
          }
        ]
      }
    end
  end
end

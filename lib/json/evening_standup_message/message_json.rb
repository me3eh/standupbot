module EveningStandupMessage
  class MessageJson
    def initialize
    end

    def call
      [
          {
            "type": "header",
            "text": {
              "type": "plain_text",
              "text": "Maciej Bociuk",
              "emoji": true
            }
          },
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "Poranny standup"
            },
            "accessory": {
              "type": "image",
              "image_url": "https://ca.slack-edge.com/T0A5H5F5M-U0236EV882D-8a70574bca2e-512",
              "alt_text": "computer thumbnail"
            }
          },
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "*Jakie plany na dziś?*\nPaid time off\n*When:*\nAug 10-Aug 13\n*Hours:* 16.0 (2 days)\n*Remaining balance:* 32.0 hours (4 days)\n*Comments:* \"Family in town, going camping!\""
            },
            "accessory": {
              "type": "image",
              "image_url": "https://ca.slack-edge.com/T0A5H5F5M-U0236EV882D-8a70574bca2e-512",
              "alt_text": "computer thumbnail"
            }
          },
          {
            "type": "actions",
            "elements": [
              {
                "type": "button",
                "text": {
                  "type": "plain_text",
                  "emoji": true,
                  "text": "Approve"
                },
                "style": "primary",
                "value": "click_me_123"
              },
              {
                "type": "button",
                "text": {
                  "type": "plain_text",
                  "emoji": true,
                  "text": "Deny"
                },
                "style": "danger",
                "value": "click_me_123"
              }
            ]
          }
        ]
    end
  end
end

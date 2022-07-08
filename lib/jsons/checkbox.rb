
module Jsons
  module Checkbox
    extend self
    def call(text:, description:)
      {
        "type": "actions",
        "elements": [
          {
            "type": "checkboxes",
            "options": [
              {
                "text": {
                  "type": "mrkdwn",
                  "text": text
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
      }
    end
  end
end
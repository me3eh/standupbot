
module Jsons
  module CheckboxOption
    extend self
    def call(text:, value:)
      {
        "text": {
          "type": "plain_text",
          "text": text,
          "emoji": true
        },
        "value": value
      }
    end

    def call_with_description(text:, description:, value:)
      {
        "text": {
          "type": "mrkdwn",
          "text": text
        },
        "description": {
          "type": "mrkdwn",
          "text": description
        },
        "value": value
      }
    end
  end
end


module Jsons
  module RadioButtonOption
    extend self
    def call(text:, description:, value:)
      {
        "text": {
          "type": "plain_text",
          "text": text,
          "emoji": true
        },
        "value": value
      }
    end
  end
end
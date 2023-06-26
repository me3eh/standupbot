module Jsons
  module FormOption
    extend self
    def call(text:, value:)
      {
        "text": {
          "type": 'plain_text',
          "text": text,
          "emoji": true
        },
        "value": value
      }
    end
  end
end

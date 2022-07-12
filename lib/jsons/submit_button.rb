module Jsons
  module SubmitButton
    extend self
    def call(text:, id_of_action:, value:)
      {
        "type": "button",
        "text": {
          "type": "plain_text",
          "text": text,
          "emoji": true
        },
        "value": value,
        "action_id": id_of_action
      }
    end
  end
end
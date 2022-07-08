
module Jsons
  module Input
    extend self
    def call(initial_value=nil, is_multiline:, text_for_label:)
      {
        "type": "input",
        "element": {
          "type": "plain_text_input",
          "multiline": is_multiline,
          "action_id": "input",
          "initial_value": string_with_initial_value(initial_value)
      },
        "label": {
          "type": "plain_text",
          "text": text_for_label,
          "emoji": true
        },
      }
    end

    private

    def string_with_initial_value(initial_value)
      if initial_value.present?
        initial_value
      else
        ""
      end
    end
  end
end
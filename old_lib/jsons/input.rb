module Jsons
  module Input
    extend self
    def call(initial_value = nil, id:, is_multiline:, text_for_label:)
      {
        "type": 'input',
        "block_id": id.to_s,
        "element": {
          "type": 'plain_text_input',
          "multiline": is_multiline,
          "action_id": id.to_s,
          "initial_value": string_with_initial_value(initial_value)
        },
        "label": {
          "type": 'plain_text',
          "text": text_for_label,
          "emoji": true
        }
      }
    end

    private

    def string_with_initial_value(initial_value)
      initial_value.present? ? initial_value : ''
    end
  end
end

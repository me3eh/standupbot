module Jsons
  module FilledInput
    extend self

    def call(label_text:, value_id:, text:)
      {
        type: 'input',
        block_id: value_id,
        element: {
          type: 'plain_text_input',
          initial_value: text.nil? ? "a" : text,
          multiline: true,
          action_id: value_id
        },
        label: {
          type: 'plain_text',
          text: label_text,
          emoji: true
        }
      }
    end
  end
end

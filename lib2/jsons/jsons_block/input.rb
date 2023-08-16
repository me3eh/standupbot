module Jsons
  module Input
    extend self

    def call(label_text:, value_id:)
      {
        type: 'input',
        block_id: value_id,
        element: {
          type: 'plain_text_input',
          multiline: true,
          max_length: 1990,
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

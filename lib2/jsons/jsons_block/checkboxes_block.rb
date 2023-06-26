module Jsons
  module CheckBox
    extend self

    def call(value_id:)
      {
        type: 'input',
        block_id: value_id,
        element: {
          type: 'checkboxes',
          action_id: value_id,
          options: [
            {
              text: {
                type: 'plain_text',
                text: 'Open for PP',
                emoji: true
              },
              value: 'open_for_PP'
            }
          ]
        },
        label: {
          type: 'plain_text',
          text: ' ',
          emoji: true
        }
      }
    end
  end
end

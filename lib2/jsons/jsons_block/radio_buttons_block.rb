module Jsons
  module RadioButton
    extend self

    def call(value_id:)
      {
        type: 'input',
        block_id: value_id,
        element: {
          type: 'radio_buttons',
          action_id: value_id,
          options: [
            {
              text: {
                type: 'plain_text',
                text: 'Stacjonarnie',
                emoji: true
              },
              value: 'stationary'
            },
            {
              text: {
                type: 'plain_text',
                text: 'Zdalnie',
                emoji: true
              },
              value: 'remote'
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

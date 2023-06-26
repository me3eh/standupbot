# frozen_string_literal: true

module Jsons
  module ActionBlock
    module_function

    def call(action_button1:)
      {
        type: 'actions',
        elements: [
          {
            type: 'button',
            text: {
              type: 'plain_text',
              text: 'Zapisz',
              emoji: true
            },
            value: 'button_1',
            action_id: action_button1,
            style: 'primary'
          },
          {
            type: 'button',
            text: {
              type: 'plain_text',
              text: 'Zamknij',
              emoji: true
            },
            value: 'button_3',
            action_id: 'actionId-3',
            style: 'danger'
          }
        ]
      }
    end
  end
end

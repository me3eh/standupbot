module Jsons
    module ActionBlock 

        extend self

        def call
            {
              type: "actions",
              elements: [
                {
                  type: "button",
                  text: {
                    type: "plain_text",
                    text: "Zapisz",
                    emoji: true
                  },
                  value: "button_1",
                  action_id: "morning_saving",
                  style: "primary"
                },
                {
                  type: "button",
                  text: {
                    type: "plain_text",
                    text: "Zamknij",
                    emoji: true
                  },
                  value: "button_3",
                  action_id: "actionId-3",
                  style: "danger"
                }
              ]
            }
          end

    end
end
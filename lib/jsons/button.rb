module Jsons
  module Button
    extend self
    def call(color: "black", text:, id_of_action:, value:)
      if color == "black"
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
      else
        {
          "type": "button",
          "text": {
            "type": "plain_text",
            "text": text,
            "emoji": true
          },
          "value": value,
          style: color_for_button(color),
          "action_id": id_of_action
        }
      end
    end

    private

    def color_for_button(color)
      case color
      when "green"
        "primary"
      else
        "danger"
      end
    end
  end
end

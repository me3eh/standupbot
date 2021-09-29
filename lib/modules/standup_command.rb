module Both_Standup_Commands
  def edit_options_alternative_options
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "Jak ma się zedytować ten standup?"
      },
      "accessory": {
        "type": "radio_buttons",
        "options": [
          {
            "text": {
              "type": "plain_text",
              "text": "Usuwając poprzedni i tworząc nową wiadomość",
              "emoji": true
            },
            "value": "delete-and-create"
          },
          {
            "text": {
              "type": "plain_text",
              "text": "Edytując uprzednio utworzoną wiadomość, bez tworzenia nowej",
              "emoji": true
            },
            "value": "edit"
          }
        ],
        initial_option:
          {
            "text": {
              "type": "plain_text",
              "text": "Edytując uprzednio utworzoną wiadomość, bez tworzenia nowej",
              "emoji": true
            },
            "value": "edit"
          },
        "action_id": "edit_option"
      }
    }
  end
  def edit_options
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "Jak ma się zedytować ten standup?"
      },
      "accessory": {
        "type": "radio_buttons",
        "options": [
          {
            "text": {
              "type": "plain_text",
              "text": "Usuwając poprzedni i tworząc nową wiadomość",
              "emoji": true
            },
            "value": "delete-and-create"
          },
          {
            "text": {
              "type": "plain_text",
              "text": "Edytując uprzednio utworzoną wiadomość, bez tworzenia nowej",
              "emoji": true
            },
            "value": "edit"
          }
        ],
        initial_option:
          {
            "text": {
              "type": "plain_text",
              "text": "Usuwając poprzedni i tworząc nową wiadomość",
              "emoji": true
            },
            "value": "delete-and-create"
          },
        "action_id": "edit_option"
      }
    }
  end
  def first_argument(index)
    index.eql?(0)
  end
end
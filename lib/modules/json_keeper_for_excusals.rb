module Keeper_excusals
  def Keeper_excusals.attachment_for_main_screen
    [
      {
        "fallback": "Something wrong happened. GIVE BACK WORKING BOT",
        "callback_id": "choice_for_excusal",
        "color": "#3AA3E3",
        "attachment_type": "default",
        "actions": [
          {
            "name": "game",
            "text": ":heavy_plus_sign: Dodaj zwolnienie",
            "type": "button",
            "style": "primary",
            "value": "add-0",
          },
          {
            "name": "game",
            "text": ":heavy_minus_sign: Usun zwolnienie",
            "type": "button",
            "style": "danger",
            "value": "delete-0",
          },
          {
            "name": "game",
            "text": "Wylistuj zwolnienia",
            "type": "button",
            "value": "list-0",
          },
        ]
      }
    ]
  end

  def Keeper_excusals.add_option__block(today_now:, user_id:)
    {
      text:"its not gonna show",
      blocks: [
        {
          "type": "header",
          "text": {
            "type": "plain_text",
            "text": "Zwolnienie ze standupu",
            "emoji": true
          }
        },
        {
          "type": "actions",
          "elements": [
            {
              "type": "datepicker",
              "initial_date": "#{today_now}",
              "placeholder": {
                "type": "plain_text",
                "text": "Select a date",
                "emoji": true
              },
              "action_id": "date-picker-1"
            },
            {
              "type": "datepicker",
              "initial_date": "#{today_now}",
              "placeholder": {
                "type": "plain_text",
                "text": "Select a date",
                "emoji": true
              },
              "action_id": "date-picker-2"
            },
            {
              "type": "users_select",
              "placeholder": {
                "type": "plain_text",
                "text": "Wybierz symulanta",
                "emoji": true
              },
              "initial_user": "#{user_id}"
            },
          ]
        },
        {
          "type": "input",
          "element": {
            "type": "plain_text_input",
            "action_id": "input"
          },
          "label": {
            "type": "plain_text",
            "text": "Powód",
            "emoji": true
          }
        },
        {
          "type": "actions",
          "elements": [
            {
              "type": "button",
              "text": {
                "type": "plain_text",
                "text": "Click Me",
                "emoji": true
              },
              "value": "click_me_123",
              "action_id": "add_excusal"
            }
          ]
        },
      ]
    }
  end

  def Keeper_excusals.delete_option__block
    # must create it before json
    p = delete_selection

    {
      text:"Not gonna show",
      blocks: [
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": "Wybierz zwolnienie z tabeli"
          },
          "accessory": {
            "type": "static_select",
            "placeholder": {
              "type": "plain_text",
              "text": "Select an item",
              "emoji": true
            },
            "options": p,
            "action_id": "static_select"
          }
        },
        {
          "type": "actions",
          "elements": [
            {
              "type": "button",
              "text": {
                "type": "plain_text",
                "text": "Zatwierdź",
                "emoji": true
              },
              "value": "click_me_123",
              "action_id": "remove_excusal"
            }
          ]
        }
      ]
    }
  end

  def delete_selection
    array_storing = []
    Free_From_Standup.all.each do |u|
      array_storing.append( {'text': {'type': 'plain_text', 'text': "ID zwolnienia:#{u.id}"}, 'value': "#{u.id}"} )
    end
    array_storing
  end

  def Keeper_excusals.list_block(team_id:)
    json_blocks = []

    1.upto(2) do
      json_blocks.append(add_json_divider)
    end

    Free_From_Standup.all.each do |u|
      name, pic = $everything_needed.get_info_about_user(team_id: team_id, user_id: u.user_id)
      json_blocks.append(add_json_blocks(id_of_excusal: u.id,
                                         beginning_date_of_excusal: u.date_of_beginning,
                                         ending_date_of_excusal: u.date_of_ending,
                                         name: name,
                                         pic: pic,
                                         excusal: u.reason))
      json_blocks.append(add_json_divider)
    end

    1.upto(2) do
      json_blocks.append(add_json_divider)
    end

    {
      text: "its not gonna show up",
      blocks: json_blocks,
    }
  end

  def add_json_blocks(id_of_excusal:, beginning_date_of_excusal:,
                      ending_date_of_excusal:, name:, pic:, excusal:)

    excusal = excusal.nil? ? "Brak powodu" : excusal
    {
      "type": "context",
      "elements": [
        {
          "type": "image",
          "image_url": pic,
          "alt_text": "cute cat"
        },
        {
          "type": "mrkdwn",
          "text": "*#{id_of_excusal}* - #{name} - od #{beginning_date_of_excusal}"+
            " do #{ending_date_of_excusal}"
        },
        {
          "type": "mrkdwn",
          "text": "* Powód: *#{excusal}"
        }
      ]
    }
  end

  def add_json_divider
    {
      "type": "divider"
    }
  end

end

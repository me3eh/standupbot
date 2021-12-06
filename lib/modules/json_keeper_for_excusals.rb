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
            "text": "Zarządzaj zwolnieniami",
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

  def delete_option__block(array_containing_excusals)
    # must create p(hashmap) before json
    p = delete_selection(array_containing_excusals)
    [
      {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "Wybierz zwolnienie z tabeli (do usunięcia)"
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
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": " "
        },
        "accessory": {
          "type": "button",
          "text": {
            "type": "plain_text",
            "text": "Zatwierdź",
            "emoji": true
          },
          "value": "click_me_123",
          "action_id": "remove_excusal"
        }
      },
  ]
  end

  def delete_selection( array_with_excusals )
    array_storing = []
    array_with_excusals.each do |u|
      array_storing.append( {'text': {'type': 'plain_text', 'text': "ID zwolnienia:#{u.id}"}, 'value': "#{u.id}"} )
    end
    array_storing
  end

  def Keeper_excusals.list_block(team_id:, page:)
    json_blocks = []

    helper = Free_From_Standup.all.order('created_at DESC')
    excusals = helper[ ( page * $iteration )..(( page * $iteration + $iteration - 1 ))]

    if excusals.empty?
      return {
        text: "Brak rekordów"
      }
    end

    excusals.each do |u|
      name, pic = $everything_needed.get_info_about_user(team_id: team_id,
                                                         user_id: u.user_id)
      json_blocks.append(add_json_blocks(id_of_excusal: u.id,
                                         beginning_date_of_excusal: u.date_of_beginning,
                                         ending_date_of_excusal: u.date_of_ending,
                                         name: name,
                                         pic: pic,
                                         excusal: u.reason))
      json_blocks.append( add_json_divider)
    end
    delete_option__block(excusals).each do |u|
      json_blocks.append(u)
    end
    {
      text: "its not gonna show up",
      blocks: json_blocks,
      attachments: direction_buttons(type_of_command: 'list', recent_value: page),
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
  
  def values_for_buttons(type_of_command:, recent_value:)
    left = 0
    right = 0
    left_caption = ''
    right_caption = ''
    case type_of_command
    when "list"
      maximal_iteration = Free_From_Standup.all.count
      right =
        ( maximal_iteration <= ( recent_value + 1 ) * $iteration ) ?
                0 : recent_value + 1
      right_caption = "Następny"
      left = ( recent_value - 1 < 0 ) ?
               ( maximal_iteration / $iteration ) :
               ( recent_value - 1 )
      left_caption = "Poprzedni"
    when "help"
      little_organization = [ ["commands", "morning_stand", "evening_stand"],
        {"commands" => 0, "morning_stand" => 1, "evening_stand" => 2 },
        {"commands" => ":sos:komendy", "morning_stand" => ":city_sunrise:pytania do poranka",
         "evening_stand" => ":city_sunset:pytania do wieczoru"}]

      left =
        little_organization[0][
          ( ( little_organization[1][recent_value] - 1 ) + 3 ) % 3 ]
      right =
        little_organization[0][
          ( little_organization[1][recent_value] + 1 ) % 3 ]

      left_caption = little_organization[2][left]
      right_caption = little_organization[2][right]

    end
    [left, right, left_caption, right_caption]
  end 

  def direction_buttons(type_of_command:, recent_value:)
    callback = type_of_command.eql?('list') ?
                 'choice_for_excusal' :
                 'help'
    left_value,
    right_value,
    left_caption,
    right_caption =
      values_for_buttons(type_of_command: type_of_command,
                         recent_value: recent_value)
    [
      {
        "fallback": "Something wrong happened. GIVE BACK WORKING BOT",
        "callback_id": callback,
        "color": "#3AA3E3",
        "attachment_type": "default",
        "actions": [
          {
            "name": "choice",
            "text": left_caption,
            "type": "button",
            "value": "#{type_of_command}-#{left_value}",
          },
          {
            "name": "game",
            "text": right_caption,
            "type": "button",
            "value": "#{type_of_command}-#{right_value}",
          }
        ]
      }
    ]
  end
end

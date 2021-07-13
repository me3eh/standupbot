SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'interactive_message', 'choice_for_excusal' do |action|
    action_payload = action[:payload]
    user_id = action_payload[:user][:id]
    team_id = action_payload[:team][:id]
    team = Team.find_by(team_id: team_id) ||
      raise("Cannot find team with ID #{team_id}.")
    slack_client = Slack::Web::Client.new(token: team.token)
    case action_payload[:actions][0][:value]
    when "add"
      add_block(user_id)
    when "delete"
      delete_block
    when "list"
      list_block(slack_client)
    else
      {text: "idk, coś się stało"}
    end
  end
end

def add_block(user_id)
  today_now = Date.today
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

def delete_block
  pk = add_to_select
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
          "options": pk,
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

def list_block(slack_client)
  json_blocks = []
  names = {}
  pics = {}
  Free_From_Standup.all.each do |u|
    name = names[:"#{u.user_id}"]
    if name.nil?
      user_info = slack_client.users_info(user: u.user_id)[:user][:profile]
      names = names.merge({"#{u.user_id}": "#{user_info[:real_name]}"})
      pics = pics.merge({"#{u.user_id}": "#{user_info[:image_192]}"})
      name = names[:"#{u.user_id}"]
    end
    pic = pics[:"#{u.user_id}"]
    json_blocks.append(add_json_blocks(id_of_excusal: u.id,
                                       beginning_date_of_excusal: u.date_of_beginning,
                                       ending_date_of_excusal: u.date_of_ending,
                                       name: name,
                                       pic: pic,
                                       excusal: u.reason))
    json_blocks.append(add_json_divider)
  end
  {
    text: "its not gonna show up",
    blocks: json_blocks,
  }
end

def add_to_select
  array_storing = []
  Free_From_Standup.all.each do |u|
    array_storing.append( {'text': {'type': 'plain_text', 'text': "ID zwolnienia:#{u.id}"}, 'value': "#{u.id}"} )
  end
  array_storing
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
                "do #{ending_date_of_excusal}\n*Powód:*#{excusal}"
      }
      ]
  }
end

def add_json_divider
  {
    "type": "divider"
  }
end

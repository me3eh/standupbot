SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'interactive_message', 'choice_for_excusal' do |action|
    action_payload = action[:payload]
    response_url = action_payload[:response_url]
    user_id = action_payload[:user][:id]

    case action_payload[:actions][0][:value]
    when "add"
      add_block(user_id)
    when "delete"
      delete_block
    when "list"
      list_block(response_url)
    else
      {text: "idk, coś się stało"}
    end

  end
end

def add_block(user_id)
  today_now = Date.today
  {
    text:"chuj",
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
              "text": "Click Me",
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

def list_block(response_url)
Faraday.post(response_url,{
  response_type: 'ephemeral',

  }.to_json, 'Content-Type' => 'application/json')
end

def add_to_select
  pk = []
  Free_From_Standup.all.each.with_index do |u, index|
    p = {'text': {'type': 'plain_text', 'text': "ID zwolnienia:#{u.id}"}, 'value': "#{u.id}"}
    pk.append(p)
  end
  pk
end
SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/no_standup' do |command|
    today_now = Date.today
    Faraday.post(command[:response_url], {
      response_type: 'ephemeral',
      "blocks": [
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
              "initial_user": "#{command[:user_id]}"
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
              "action_id": "actionId-3"
            }
          ]
        }
      ]
    }.to_json, 'Content-Type' => 'application/json')
  { ok: true }
  end
end
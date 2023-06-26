SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/who_doesnt_standup' do
    today_now = Date.today
    ar = static_select
    {
      "text": 'idk',
      "blocks": [
        {
          "type": 'section',
          "text": {
            "type": 'mrkdwn',
            "text": 'Wybierz date, dla której byś chciał wyświetlić listę'
          },
          "accessory": {
            "type": 'datepicker',
            "initial_date": "#{today_now}",
            "placeholder": {
              "type": 'plain_text',
              "text": 'Select a date',
              "emoji": true
            },
            "action_id": 'datepicker-action'
          }
        },
        {
          "type": 'input',
          "element": {
            "type": 'static_select',
            "placeholder": {
              "type": 'plain_text',
              "text": 'Select an item',
              "emoji": true
            },
            "options": ar,
            "action_id": 'static_select_action'
          },
          "label": {
            "type": 'plain_text',
            "text": 'Wybierz zwolnienie od którego zacząć(prywatnie) lub które wyświetlić(publicznie)'
          }
        },
        {
          "type": 'actions',
          "elements": [
            {
              "type": 'checkboxes',
              "options": [
                {
                  "text": {
                    "type": 'mrkdwn',
                    "text": '*Czy chcesz, by twoja komenda została wyświetlona dla wszystkich?*'
                  },
                  "description": {
                    "type": 'mrkdwn',
                    "text": 'P.S. Nie chcesz tego'
                  },
                  "value": 'value-2'
                }
              ],
              "action_id": 'action'
            }
          ]
        },
        {
          "type": 'actions',
          "elements": [
            {
              "type": 'button',
              "text": {
                "type": 'plain_text',
                "text": 'Click Me',
                "emoji": true
              },
              "value": 'click_me_123',
              "action_id": 'who_doesnt_standup'
            }
          ]
        }
      ]
    }
  end
end

def static_select
  text = ['Brak zwolnienia', 'Tylko poranne', 'Tylko wieczorne', 'Oba złożone', 'Zwolnienia']
  p = []
  0.upto(4) do |u|
    p.append({ "text": { "type": 'plain_text', "text": "#{text[u]}" }, "value": "#{u}" })
  end
  p
end

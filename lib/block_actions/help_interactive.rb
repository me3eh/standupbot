SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'interactive_message', 'help' do |action|

    morning_standup =
      "*/morning_standup* - wygadaj się z rana przy kawie\n"+
        "Użycie: wpisujesz /morning_standup => wciskasz enter => uzupelniasz formularz => zatwierdzasz formularz"

    evening_standup =
      "*/evening_standup* - wyżal się wieczorem przy piwie\n"+
        "Użycie: wpisujesz /evening_standup => wciskasz enter => uzupelniasz formularz => zatwierdzasz formularz"

    who_doesnt_standup =
      "*/who_doesnt_standup* - pokazuje urwisów, którzy się nie wygadują\n"+
        "Użycie: wpisujesz /who_doesnt_standup => wciskasz enter => uzupełniasz formularz => zatwierdzasz formularz"

    help = "*/help*\nP-patrzysz na to teraz :point_right::point_left:"
    no_standup = "*/excusal*\n - do wyboru do koloru - dodawanie, listowanie oraz usuwanie zwolnień\n"+
      "Użycie: wpisujesz /excusal => wciskasz enter => uzupełniasz formularz => zatwierdzasz formularz"
    ping_stationary ="*/ping_people_stationary*\n - spinguj ludzie będących w pracy (przydatne przy obiadkach (bierze ludzi, którzy zazmaczyli stacjonarnie oraz nie zrobili standupu)\n"+
      "Użycie: wpisujesz /ping_people_stationary => wciskasz enter => patrzysz kto jest i możesz spingować"

    action_payload = action[:payload]
    choice = action_payload[:actions][0][:value].split('-')[1]
    include Keeper_post_standup
    include Keeper_excusals
    case choice
    when "commands"
      {
        text: "not gonna show up",
        blocks: [
          {
            "type": "divider"
          },
          {
            "type": "divider"
          },
          {
            "type": "divider"
          },
          {
            "type": "header",
            "text": {
              "type": "plain_text",
              "text": "Spis",
            }
          },
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": morning_standup
            }
          },
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": evening_standup
            }
          },
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": who_doesnt_standup
            }
          },
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": no_standup
            }
          },
          # {
          #   "type": "section",
          #   "text": {
          #     "type": "mrkdwn",
          #     "text": ping_stationary
          #   }
          # },
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": help
            }
          },
        ],
        attachments:
          direction_buttons(
            type_of_command: 'help',
            recent_value: "commands")
      }
    when "morning_stand"
          {
          text: "not gonna show up",
          "blocks": [
            {
            "type": "header",
            "text": {
                "type": "plain_text",
                text: "Pytania na standup poranny:",
                }
          },
            {
              "type": "section",
              "text": {
                "type": "mrkdwn",
                "text": MORNING_NOTIFICATION,
              }
            },
          ],
          "attachments":
            direction_buttons(
              type_of_command: 'help',
              recent_value: "morning_stand")
          }
    when "evening_stand"
      {
        text: "not gonna show up",
        "blocks": [
        {
          "type": "header",
          "text": {
            "type": "plain_text",
            text: "Pytania na standup wieczorny:",
          }
        },
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": EVENING_NOTIFICATION,
          }
        },
        ],
        "attachments":
          direction_buttons(
            type_of_command: 'help',
            recent_value: "evening_stand")
      }
    end

  end
end

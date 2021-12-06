
SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/help' do |command|
    # team = Team.find_by(team_id: command[:team_id].to_s) ||
    #   raise("Cannot find team with ID #{command[:team_id]}.")

    # slack_client = Slack::Web::Client.new(token: team.token)
    # command_channel = command[:channel_id]
    # command_user = command[:user_id]
    {
      text: "Wybierz sobie opcje :flushed: :point_right::point_left:",
      attachments: [
        {
          "fallback": "Something wrong happened. GIVE BACK WORKING BOT",
          "callback_id": "help",
          "color": "#3AA3E3",
          "attachment_type": "default",
          "actions": [
            {
              "name": "help",
              "text": ":sos: Pomocy!",
              "type": "button",
              "style": "danger",
              "value": "help-commands",
            },
            {
              "name": "help",
              "text": ":city_sunrise: Poranne pytanka",
              "type": "button",
              "value": "help-morning_stand",
            },
            {
              "name": "help",
              "text": ":city_sunset: Wieczorne pytanka",
              "type": "button",
              "value": "help-evening_stand",
            },
         ]
        }
      ]
    }
    # slack_client.chat_postEphemeral(
    #   channel: command_channel,
    #   user: command_user,
    #   "blocks": [
    #     {
    #       "type": "divider"
    #     },
    #     {
    #       "type": "divider"
    #     },
    #     {
    #       "type": "divider"
    #     },
    #     {
    #       "type": "header",
    #       "text": {
    #         "type": "plain_text",
    #         "text": "Spis",
    #       }
    #     },
    #     {
    #       "type": "section",
    #       "text": {
    #         "type": "mrkdwn",
    #         "text": morning_standup
    #       }
    #     },
    #     {
    #       "type": "section",
    #       "text": {
    #         "type": "mrkdwn",
    #         "text": evening_standup
    #       }
    #     },
    #     {
    #       "type": "section",
    #       "text": {
    #         "type": "mrkdwn",
    #         "text": who_doesnt_standup
    #       }
    #     },
    #     {
    #       "type": "section",
    #       "text": {
    #         "type": "mrkdwn",
    #         "text": no_standup
    #       }
    #     },
    #     {
    #       "type": "section",
    #       "text": {
    #         "type": "mrkdwn",
    #         "text": help
    #       }
    #     },
    #   ],
    # )
    # slack_client.chat_postEphemeral(
    #   channel: command_channel,
    #   user: command_user,
      # "blocks": [
      #   {
      #     "type": "header",
      #     "text": {
      #       "type": "plain_text",
      #       text: "Pytania na standup poranny:",
      #       }
      #   },
      # ],
      # "attachments":[
      #   {
      #     "text": MORNING_NOTIFICATION,
      #     "color": "#ff44cc",
      #   },
      # ],
    # )
    # slack_client.chat_postEphemeral(
    #   channel: command_channel,
    #   user: command_user,
    #   "blocks": [
    #     {
    #       "type": "header",
    #       "text": {
    #         "type": "plain_text",
    #         text: "Pytania na standup wieczorny:",
    #       }
    #     },
    #   ],
    #   "attachments":[
    #     {
    #       "text": EVENING_NOTIFICATION,
    #       "color": "#00ffff",
    #     },
    #   ],
    # )
    # { text: "Twoja komenda:\n"+"#{command[:command]} #{command[:text]}"}
  end
end
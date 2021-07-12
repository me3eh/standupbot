SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/no_standup' do |command|
    team = Team.find_by(team_id: command[:team_id].to_s) ||
      raise("Cannot find team with ID #{command[:team_id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)


    slack_client.chat_postEphemeral(
      channel: command[:channel_id],
      user: command[:user_id],
      "text": "Wybierz swoją opcję",
      "attachments": [
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
            "value": "add",
          },
          {
            "name": "game",
            "text": ":heavy_minus_sign: Usun zwolnienie",
            "type": "button",
            "style": "danger",
            "value": "delete",
      },
          {
            "name": "game",
            "text": "Wylistuj zwolnienia",
            "style": "danger",
            "value": "list",
          },
        ]
      }
      ]
    )
    {
      "blocks":[
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": "Jezeli chcesz, usun wszystkie teksty tylko widoczne dla ciebie"
          },
          "accessory": {
            "type": "button",
            "text": {
              "type": "plain_text",
              "text": "Klikej jezeli jestes pewien :flushed:",
              "emoji": true
            },
            "value": "click",
            "action_id": "deleting"
          }
        }
      ]
    }
  end
end
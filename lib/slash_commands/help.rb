
SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/help' do |command|
    morning_standup = "*/morning_standup* - wygadaj się z rana przy kawie\n"+
                      "Użycie: */morning_standup 1.[coś]2.[coś]3.[coś]4.[coś]*"
    evening_standup = "*/morning_standup* - wyżal się wieczorem przy piwie\n"+
                      "Użycie: */evening_standup 1.[coś]2.[coś]3.[coś]4.[coś]*"
    who_doesnt_standup = "*/who_doesnt_standup* - pokazuje urwisów, którzy się nie wygadują\n"+
      "Użycie: */who_doesnt_standup YYYY-MM-DD*\n (MM = <1:12>, D =<1:31>)"
    help = "*/help*\nP-patrzysz na to teraz :point_right::point_left:"
    team = Team.find_by(team_id: command[:team_id].to_s) || raise("Cannot find team with ID #{command[:team_id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)
    command_channel = command[:channel_id]
    command_user = command[:user_id]
    slack_client.chat_postEphemeral(channel: command_channel,
                                    user: command_user,
                                  "blocks": [
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
                                      "text": help
                                    }
                                  },
                                  ],
                                  )
    slack_client.chat_postEphemeral(channel: command_channel,
                                    user: command_user,
                                    "blocks": [
                                      {
                                        "type": "header",
                                        "text": {
                                          "type": "plain_text",
                                          text: "Pytania na standup poranny:",
                                        }
                                      },
                                    ],
                                    "attachments":[
                                    {
                                      "text": MORNING_NOTIFICATION,
                                      "color": "#ff44cc",
                                    },
                                    ],
                                    )
    slack_client.chat_postEphemeral(channel: command_channel,
                                    user: command_user,
                                    "blocks": [
                                      {
                                        "type": "header",
                                        "text": {
                                          "type": "plain_text",
                                          text: "Pytania na standup wieczorny:",
                                        }
                                      },
                                    ],
                                    "attachments":[
                                    {
                                      "text": EVENING_NOTIFICATION,
                                      "color": "#00ffff",
                                    },
                                  ],
                                  )
    { text: "Twoja komenda:\n"+
      "#{command[:command]} #{command[:text]}"
    }
  end
end
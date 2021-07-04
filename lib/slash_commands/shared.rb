
def contains_number(str, number)
  !!(str =~ /#{number}/)
end

def missing_points(array, slack_client, channel_id, command_user, notification)
  word = "\""
  array.each_with_index do |number, index|
    word += number.to_s
    if index != array.size - 1
      word += ", "
    end
  end
  word += "\""
  correct_form = array.size.equal?(1) ? "punktu" : "punktow"
  slack_client.chat_postEphemeral(channel: channel_id,
                                  user: command_user,
                                  "blocks": [
                                    {
                                      "type": "header",
                                      "text": {
                                        "type": "plain_text",
                                        "text": "Brak #{word} #{correct_form}. Tak dla przypomnienia:}",
                                        "emoji": true
                                      }
                                    }
                                  ],
                                  "attachments": [
                                    {
                                      "text": notification,
                                      "color": "#ff0000",
                                    }
                                  ],
                                  )
end

def not_correct_order(slack_client, channel_id, command_user, morning_or_evening)
  pic = morning_or_evening ?
          "https://cdn.discordapp.com/attachments/766045866724163647/861348965043404810/comment_dtoZziPOPyhrsqZLkj29rK5vD0lXBPDa.jpg" :
          "https://cdn.discordapp.com/attachments/766045866724163647/861360571706376202/ezgif-1-8349cc09efba.gif"
  text = morning_or_evening ?
           "Wierzę, że się starałeś. Trzymaj muchomora za to" :
           "Essa, wywaliłeś program"

  slack_client.chat_postEphemeral(channel: channel_id,
                                  user: command_user,
                                  "blocks": [
                                    {
                                      "type": "header",
                                      "text": {
                                        "type": "plain_text",
                                        "text": "Zla kolejnosc.",
                                        "emoji": true
                                      }
                                    },

                                    {
                                      "type": "section",
                                      "text": {
                                        "type": "mrkdwn",
                                        "text": text
                                      }
                                    },
                                    {
                                      "type": "image",
                                      "image_url": pic,
                                      "alt_text": "Inspiracja"
                                    }
                                  ],
                                  )
end

def post_public(slack_client, command_channel, name_of_user, word, morning_or_evening)
  slack_client.chat_postMessage(channel: command_channel,
                                as_user: true,
                                "blocks": [
                                  {
                                    "type": "header",
                                    "text": {
                                      "type": "plain_text",
                                      "text": "Standup #{morning_or_evening}: #{name_of_user}",
                                      "emoji": true
                                    }
                                  }
                                ],
                                "attachments": [
                                  {
                                    "text": "#{word[0]}\n\n"+
                                      "#{word[1]}\n\n"+
                                      "#{word[2]}\n\n"+
                                      "#{word[3]}\n",
                                    "color": "#00ff00",
                                  }
                                ],
                                )
end

def check_order(str)
  !!(str =~ /^1[.].*2[.].*3[.].*4[.]/)
end
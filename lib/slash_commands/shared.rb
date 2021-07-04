
def contains_number(str, number)
  !!(str =~ /#{number}/)
end

def information_about(array, slack_client, channel_id, command_user, notification)
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

def postPublic(slack_client, command_channel, name_of_user, word, morning_or_evening)

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
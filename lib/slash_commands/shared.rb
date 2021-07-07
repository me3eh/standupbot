MORNING_NOTIFICATION = "1. Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?\n\n"+
  "2. Jakie widzisz zagrożenia i blockery w powyższej liście?\n\n"+
  "3. Czy w któryms z powyższych tematów chciałbyś otrzymać pomoc?\n\n"+
  "4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu"+
  " konsultacji / podzielenia się wiedzą doświadczeniami ?\n"

EVENING_NOTIFICATION =  "1. Co udało ci sie dzisiaj skończyć?\n\n"+
  "2. Które zadań nie zostały zakończone i na jakim etapie dzisiaj "+
  "je pozostawiasz ? (pamiętałeś żeby wypchnąć je do repo?)\n\n"+
  "3. Pojawiły się jakieś blockery?\n\n"+
  "4. Czego nowego się dziś nauczyłeś / dowiedziałeś ? A jeśli niczego "+
  "to czego w danym temacie chciałbyś się dowiedzieć ? Daj nam sobie pomóc\n"
def contains_number(str, number)
  !!(str =~ /#{number}/)
end

# def missing_points(array, slack_client, channel_id, command_user, notification)
#   word = "\""
#   array.each_with_index do |number, index|
#     word += number.to_s
#     if index != array.size - 1
#       word += ", "
#     end
#   end
#   word += "\""
#   correct_form = array.size.equal?(1) ? "punktu" : "punktow"
#   slack_client.chat_postEphemeral(channel: channel_id,
#                                   user: command_user,
#                                   "blocks": [
#                                     {
#                                       "type": "header",
#                                       "text": {
#                                         "type": "plain_text",
#                                         "text": "Brak #{word} #{correct_form}. Tak dla przypomnienia:}",
#                                         "emoji": true
#                                       }
#                                     }
#                                   ],
#                                   "attachments": [
#                                     {
#                                       "text": notification,
#                                       "color": "#ff0000",
#                                     }
#                                   ],
#                                   )
# end
#
# def not_correct_order(slack_client, channel_id, command_user, morning_or_evening)
#   pic = morning_or_evening ?
#           "https://cdn.discordapp.com/attachments/766045866724163647/861348965043404810/comment_dtoZziPOPyhrsqZLkj29rK5vD0lXBPDa.jpg" :
#           "https://cdn.discordapp.com/attachments/766045866724163647/861360571706376202/ezgif-1-8349cc09efba.gif"
#   text = morning_or_evening ?
#            "Wierzę, że się starałeś. Trzymaj muchomora za to" :
#            "Essa, wywaliłeś program"
#
#   slack_client.chat_postEphemeral(channel: channel_id,
#                                   user: command_user,
#                                   "blocks": [
#                                     {
#                                       "type": "header",
#                                       "text": {
#                                         "type": "plain_text",
#                                         "text": "Zla kolejnosc.",
#                                         "emoji": true
#                                       }
#                                     },
#
#                                     {
#                                       "type": "section",
#                                       "text": {
#                                         "type": "mrkdwn",
#                                         "text": text
#                                       }
#                                     },
#                                     {
#                                       "type": "image",
#                                       "image_url": pic,
#                                       "alt_text": "Inspiracja"
#                                     }
#                                   ],
#                                   )
# end

def post_public(slack_client:, command_channel:, name_of_user:, word:, is_morning:)
  place = word[4].present? ? "\n\n\n*##{word[4]}*" : " "
  pretext = is_morning ? MORNING_NOTIFICATION : EVENING_NOTIFICATION
  morning_or_evening = is_morning ?  "poranny" : "wieczorny"
  slack_client.chat_postMessage(channel: command_channel,
                                "blocks": [
                                  {
                                    "type": "header",
                                    "text": {
                                      "type": "plain_text",
                                      "text": "Standup #{morning_or_evening}: "+
                                              "#{name_of_user}",
                                      "emoji": true
                                    }
                                  }
                                ],
                                "attachments": [
                                  {
                                    "pretext": pretext,
                                    "text": "1. #{word[0]}\n\n"+
                                      "2. #{word[1]}\n\n"+
                                      "3. #{word[2]}\n\n"+
                                      "4. #{word[3]}"+
                                    "#{place}",
                                    "color": "#00ff00",
                                  }
                                ],
                                )
end

def list_users_with_activity(type_of_text:, slack_client:, command_channel:, command_user:, content_attachment:, date:)
  text_for_header = type_of_header(type_of_text)
  color_for_attachment = type_of_color(type_of_text)

  slack_client.chat_postEphemeral(channel: command_channel,
                                  user: command_user,
                                "blocks": [
                                  {
                                    "type": "header",
                                    "text": {
                                      "type": "plain_text",
                                      "text": "#{text_for_header} w dniu #{date}",
                                      "emoji": true
                                    }
                                  }
                                ],
                                "attachments": [
                                  {
                                    "text": "#{content_attachment}",
                                    "color": "#{color_for_attachment}",
                                  }
                                ],
                                )
end

def attachment_content(hashmap, users)
  word = ""
  users.each do |u|
    word += "#{hashmap[u.to_s]}\n\n"
  end
  word
end

def type_of_header(type_of_text)
  case type_of_text
  when 0
    "Osoby, które nie złożyły standupu"
  when 1
    "Osoby, które złożyły tylko standup poranny"
  when 2
    "Osoby, które złożyły tylko standup wieczorny"
  when 3
    "Osoby, które złożyły oba standupy i są już wolne"
  else
    "Idk, coś zwaliłeś"
  end
end

def type_of_color(type_of_text)
  case type_of_text
  when 0
    "#ff0000"
  when 1..2
    "#ffff00"
  when 3
    "#00ff00"
  else
    "Idk, coś zwaliłeś"
  end
end

def incorrect_data(slack_client, channel_id, command_user)
  pic = "https://cdn.discordapp.com/attachments/766045866724163647/861524060445081620/ezgif.com-gif-maker3.gif"
  slack_client.chat_postEphemeral(channel: channel_id,
                                  user: command_user,
                                  "blocks": [
                                    {
                                      "type": "header",
                                      "text": {
                                        "type": "plain_text",
                                        "text": "Zla data",
                                        "emoji": true
                                      }
                                    },
                                    {
                                      "type": "section",
                                      "text": {
                                        "type": "mrkdwn",
                                        "text": "Albo podałeś datę przed narodzinami bota, albo witamy w przyszłości"
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

def invalid_data(slack_client, command_channel, command_user)
  pic = "https://cdn.discordapp.com/attachments/766045866724163647/861541674361552916/heavy.gif"
  slack_client.chat_postEphemeral(channel: command_channel,
                                  user: command_user,
                                  "blocks": [
                                    {
                                      "type": "header",
                                      "text": {
                                        "type": "plain_text",
                                        "text": "Nie zastosowałeś się do moich poleceń",
                                        "emoji": true
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

def invalid_format(slack_client, command_channel, command_user)
  pic = "https://cdn.discordapp.com/attachments/766045866724163647/861541674361552916/heavy.gif"
  slack_client.chat_postEphemeral(channel: command_channel,
                                  user: command_user,
                                  "blocks": [
                                    {
                                      "type": "header",
                                      "text": {
                                        "type": "plain_text",
                                        "text": "No troszkę zepsułeś komendę",
                                        "emoji": true
                                      }
                                    },
                                    {
                                      "type": "section",
                                      "text": {
                                        "type": "mrkdwn",
                                        "text": "Zły format daty:\n Użycie: */who_doesnt_standup YYYY-MM-DD*, gdzie MM <1:12>, a DD <1:31>\n"+
                                                "np. /who_doesnt_stanup 2137-12-30"
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

def check_order(str)
  !!(str =~ /^1[.].*2[.].*3[.].*4[.]/)
end

def check_command(str)
  !!(str =~ /^[2][0-9]{3}-((0[0-9])|(1[1-2]))-(([0-2][0-9])|3[0-1]$)/)
end

def randomizing
  word = ""
  prng = Random.new
  if prng.rand(1000).equal?(213)
    word = "\nW sumie przepraszam, ze musisz widzieć ten ukryty komunikat, ale Maciek to na mnie wymusił \n"+
      "    :flushed:\n"+
      ":point_right: :point_left:"
  end
  word
end

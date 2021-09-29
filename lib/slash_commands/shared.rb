 $iteration = 10

def list_users_private(type_of_text:,
                       content_attachment:,
                       date:,
                       response_url:,
                       counts:,
                       first:)
  text_for_header = type_of_header(type_of_text)
  color_for_attachment = type_of_color(type_of_text)
  message = message_creation(text_for_header: text_for_header,
                             color_for_attachment: color_for_attachment,
                             date: date,
                             counts:counts,
                             content_attachment: content_attachment)
  if first
    Faraday.post(response_url, message
  .to_json, 'Content-Type' => 'application/json')
  else
    message
  end
end

 def message_creation(text_for_header:,
                      date:,
                      content_attachment:,
                      color_for_attachment:,
                      counts:)
   {
     "text": "Dzięki za przeslanie",
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
         "fallback": "Something wrong happened. GIVE BACK WORKING BOT",
         "callback_id": "who_doesnt_standup",
         "attachment_type": "default",
         "actions": [
           {
             "name": "nothing",
             "text": "Brak standupu(#{counts[0]})",
             "type": "button",
             "value": "nothing/#{date}",
           },
           {
             "name": "only_morning",
             "text": "Poranne standupy(#{counts[1]})",
             "type": "button",
             "value": "only_morning/#{date}",
           },
           {
             "name": "only_evening",
             "text": "Wieczorne standupy(#{counts[2]})",
             "type": "button",
             "value": "only_evening/#{date}",
           },
           {
             "name": "both",
             "text": "Oba standupy(#{counts[3]})",
             "type": "button",
             "value": "both/#{date}",
           },
           {
             "name": "excusal",
             "text": "Zwolnienia(#{counts[4]})",
             "type": "button",
             "value": "excusal/#{date}",
             "style": "danger",
           },
         ]
       }
     ]
   }
 end
def list_users_public(type_of_text:,
                      slack_client:,
                      command_channel:,
                      content_attachment:,
                      date:)
  text_for_header = type_of_header(type_of_text)
  color_for_attachment = type_of_color(type_of_text)
  slack_client.chat_postMessage(
    channel: command_channel,
    "blocks": [
      {
        "type": "header",
        "text": {
          "type": "plain_text",
          "text": "#{text_for_header} w dniu #{date}",
          "emoji": true
        }
      },
    ],
    "attachments": [
      {
        "text": "#{content_attachment}",
        "color": "#{color_for_attachment}",
      }
    ],
    )
end

# def attachment_content(hashmap:, users:, team_id:)
def attachment_content(users:, team_id:)
  word = ""
  word = "Brak" if users.empty?
  users.each do |u|
    # word += "#{hashmap[u]}\n\n"
    word += "#{$everything_needed.get_info_about_user(team_id: team_id,user_id: u)[0]}\n\n"
  end
  word = "#{word}\n\n\n\n"
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
  when 4
    "Osoby zwolnione ze standupu"
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
  when 4
    "#aa00ff"
  else
    "Idk, coś zwaliłeś"
  end
end

def incorrect_data(slack_client:, channel_id:, command_user:, date:, birth_date_of_bot:, today:)
  pic = "https://cdn.discordapp.com/attachments/766045866724163647/861524060445081620/ezgif.com-gif-maker3.gif"
  words = "Albo podałeś datę przed narodzinami bota, albo witamy w przyszłości\n"
  words += "Podałeś datę: #{date}\n"
  words += "Bot narodzony: #{birth_date_of_bot}\n"
  words += "Dzisiejszy data: #{today}"

  slack_client.chat_postEphemeral(
    channel: channel_id,
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
          "text": words
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

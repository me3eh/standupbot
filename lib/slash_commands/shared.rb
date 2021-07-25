 $iteration = 2
# def post_public_morning(slack_client:,
#                 command_channel:,
#                 name_of_user:,
#                 word:, pic:)
#   open_for_pp = word[4] ? "\t*#Open for PP*" : " "
#   place = "\n\n\n*##{word[5]}*"
#   slack_client.chat_postMessage(
#     channel: command_channel,
#     "blocks": [
#       {
#         "type": "header",
#         "text": {
#           "type": "plain_text",
#           "text": "Standup poranny: "+
#             "#{name_of_user}",
#           "emoji": true
#         }
#       },
#       {
#         "type": "section",
#         "block_id": "section567",
#         "text": {
#           "type": "mrkdwn",
#           "text": MORNING_NOTIFICATION
#         },
#         "accessory": {
#           "type": "image",
#           "image_url": "#{pic}",
#           "alt_text": "Profile_picture"
#         }
#       },
#     ],
#
#     "attachments": [
#       {
#         "text": "1. #{word[0]}\n\n"+
#           "2. #{word[1]}\n\n"+
#           "3. #{word[2]}\n\n"+
#           "4. #{word[3]}"+
#           "#{place}#{open_for_pp}",
#         "color": "#00ff00",
#       }
#     ],
#   )
# end

def post_public_evening(slack_client:,
               command_channel:,
               name_of_user:,
               word:, pic:)
  slack_client.chat_postMessage(
  channel: command_channel,
  "blocks": [
    {
      "type": "header",
      "text": {
        "type": "plain_text",
        "text": "Standup wieczorny: "+
          "#{name_of_user}",
        "emoji": true
      }
    },
    {
      "type": "section",
      "block_id": "section567",
      "text": {
        "type": "mrkdwn",
        "text": EVENING_NOTIFICATION
      },
      "accessory": {
        "type": "image",
        "image_url": "#{pic}",
        "alt_text": "Profile_picture"
      }
    },
  ],

  "attachments": [
    {
      "text": "1. #{word[0]}\n\n"+
        "2. #{word[1]}\n\n"+
        "3. #{word[2]}\n\n"+
        "4. #{word[3]}\n\n\n"+
        "*PRy/Tickety i ich estymacje:*\n\n #{word[4]}",
      "color": "#00ff00",
    }
  ],
  )
end

def list_users_private(type_of_text:,
                       slack_client:,
                       command_channel:,
                       command_user:,
                       content_attachment:, date:)
  text_for_header = type_of_header(type_of_text)
  color_for_attachment = type_of_color(type_of_text)
  slack_client.chat_postEphemeral(
    channel: command_channel,
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

def list_users_public(type_of_text:, slack_client:,
                      command_channel:, content_attachment:, date:)
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
  users.each do |u|
    # word += "#{hashmap[u]}\n\n"
    word += "#{$everything_needed.get_info_about_user(team_id: team_id,user_id: u)[0]}\n\n"
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

module Keeper_post_standup
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
  def post_public_morning(slack_client:,
                          command_channel:,
                          name_of_user:,
                          word:, pic:)
    open_for_pp = word[4] ? "\t*#Open for PP*" : " "
    place = "\n\n\n*##{word[5]}*"
    slack_client.chat_postMessage(
      channel: command_channel,
      "blocks": [
        {
          "type": "header",
          "text": {
            "type": "plain_text",
            "text": "Standup poranny: "+
              "#{name_of_user}",
            "emoji": true
          }
        },
      ],
      "attachments": [
        fields:[
          {
            "title": "1. Zadania na dziś",
            "value": word[0],
            "short": false
          },
          {
            "title": "2. Blockery",
            "value": word[1],
            "short": false
          },
          {
            "title": "3. Pomoc?",
            "value": word[2],
            "short": false
          },
          {
            "title": "4. Kompan do pomocy?",
            "value": word[3],
            "short": false
          },
        ],
        footer: " #{place} #{open_for_pp}",
        color: "#bfff00",
        thumb_url: "#{pic}",
      ],
      as_user: true,
      )
  end

  def Keeper_post_standup.post_public_evening(slack_client:,
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
      ],

      "attachments": [
        fields:[
          {
            "title": "1. Co ukończone?",
            "value": word[0],
            "short": false
          },
          {
            "title": "2. Co nieukończone?",
            "value": word[1],
            "short": false
          },
          {
            "title": "3. Blockery podczas dnia",
            "value": word[2],
            "short": false
          },
          {
            "title": "4. Jakie wnioski?",
            "value": word[3],
            "short": false
          },
          {
            "title": "PR'ki, tickeciki itd.",
            "value": word[4],
            "short": false
          },
        ],
        color: "#1B4D3E",
        thumb_url: "#{pic}",
      ],
      )
  end
  def Keeper_post_standup.stationary_or_remotely(choice)
    choice.eql?("Stacjonarnie") ? 1 : 2
  end
end

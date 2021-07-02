require_relative 'default'

SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/morning_standup' do |command|
    team = Team.where(team_id: command[:team_id]).first || raise("Cannot find team with ID #{command[:team_id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)
    what_number = []
    (1..4).each do |i|
      word = contains_number(command[:text].to_s, "#{i}.")
      unless word
        what_number.append(i)
      end
    end
    if what_number.empty?
      {text: 'Wszystko jest pięknie. Dziękuję za standup'}
    else
      information_about(what_number, slack_client, command[:channel_id])
    end
    { text: "Jezeli chcesz edytować swój standup, oto co napisałeś:\n"+
      "#{command[:command]} #{command[:text]}"
    }

  end
end


def information_about(array, slack_client, channel_id)
  word = "\""
  array.each_with_index do |number, index|
    word += number.to_s
    if index != array.size - 1
      word += ", "
    end
  end
  word += "\""
  slack_client.chat_postMessage(channel: channel_id,
                                "blocks": [
                                  {
                                    "type": "header",
                                    "text": {
                                      "type": "plain_text",
                                      "text": "Brak punktów: #{word}. Dla przypomnienia:",
                                      "emoji": true
                                    }
                                  }
                                ],
                                "attachments": [
                                  {
                                    "text": "1.Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?\n\n"+
                                      "2. Jakie widzisz zagrożenia i blockery w powyższej liście?\n\n"+
                                      "3. Czy w któryms z powyższych tematów chciałbyś otrzymać pomoc?\n\n"+
                                      "4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu"+
                                      "/ konsultacji / podzielenia się wiedzą doświadczeniami?\n",
                                    "color": "#ff0000",
                                  }
                                ],
                                "text": "Użycie: 1. [coś] 2. [coś] 3. [coś] 4. [coś]"
  )
end
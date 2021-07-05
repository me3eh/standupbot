MORNING_NOTIFICATION = "1. Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?\n\n"+
  "2. Jakie widzisz zagrożenia i blockery w powyższej liście?\n\n"+
  "3. Czy w któryms z powyższych tematów chciałbyś otrzymać pomoc?\n\n"+
  "4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu"+
  " konsultacji / podzielenia się wiedzą doświadczeniami ?\n"

SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/morning_standup' do |command|
    team = Team.find_by(team_id: command[:team_id].to_s) || raise("Cannot find team with ID #{command[:team_id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)
    command_text = command[:text]
    command_user = command[:user_id]
    command_channel = command[:channel_id]

    time_now = Time.now()
    date_now = Date.new(time_now.year, time_now.month, time_now.day)

    what_number = []
    (1..4).each do |i|
      word = contains_number(command_text.to_s, "#{i}.")
      unless word
        what_number.append(i)
      end
    end
    if what_number.empty?
      if check_order(command_text)
        word = []
        (1..4).each do |i|
          case i
          when 4
            word[i-1] = command_text[/[4][.].*$/,0].to_s
          else
            word[i-1] = command_text[/["#{i}"][.][^(#{i+1}.)]*[#{i+1}][.]/,0].to_s.delete_suffix("#{i+1}.")
          end
        end
        post_public(slack_client, command_channel, slack_client.users_info(user: command_user)[:user][:profile][:real_name], word, "poranny")
        standup = Standup_Check.find_by(user_id: command_user, date_of_stand: date_now, team: team.team_id)
        if standup.nil?
          Standup_Check.create(team: team.team_id, user_id: command_user, morning_stand: true, date_of_stand: date_now)
        else
          unless standup.morning_stand
            standup.update(morning_stand: true)
          end
        end
      else
        not_correct_order(slack_client, command_channel, command_user, false)
      end
    else
      missing_points(what_number, slack_client, command_channel, command_user, MORNING_NOTIFICATION)
    end
    { text: "Jezeli chcesz edytować swój standup, oto co napisałeś:\n"+
            "#{command[:command]} #{command_text}"
    }
  end
end

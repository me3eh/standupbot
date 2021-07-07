FIRST_DAY_OF_BOT = Date.new(2021, 7, 5)

SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/who_doesnt_standup' do |command|
    time = Time.now
    command_text = command[:text]
    command_team = command[:team_id]
    command_channel = command[:channel_id]
    command_user = command[:user_id]
    date_now = Date.today
    team = Team.find_by(team_id: command_team.to_s) || raise("Cannot find team with ID #{command_team}.")
    slack_client = Slack::Web::Client.new(token: team.token)
    users_and_bots_in_channel = slack_client.conversations_members(channel: command_channel)[:members]
    hashmap = {}
    everything_about = []
    users_in_channel = []

    if check_command(command_text)
      year, month, day = command_text.split("-")
      date_requested = Date.new(year.to_i, deleting_zero(month).to_i, deleting_zero(day).to_i)
      if Date.valid_date?(year.to_i, month.to_i, day.to_i)
        if date_requested > date_now || date_requested < FIRST_DAY_OF_BOT
          incorrect_data(slack_client, command_channel, command_user)
        else
          users_and_bots_in_channel.each_with_index do |u, index|
            everything_about.append(slack_client.users_info(user: u)[:user])
            hashmap = hashmap.merge({u.to_s => everything_about[index][:profile][:real_name].to_s})
            unless everything_about[index][:is_bot]
              users_in_channel.append(u)
            end
          end
          word = []
          word.append(Standup_Check.where(date_of_stand: date_requested, team: command_team, morning_stand: true).map(&:user_id))
          word.append(Standup_Check.where(date_of_stand: date_requested, team: command_team, evening_stand: true).map(&:user_id))
          word.append(word[0] & word[1])
          word.append(users_in_channel - word[0] - word[1])
          word.insert(0, word.delete_at(3))
          (1..2).each do |i|
            word[i] = word[i] - word[3]
          end
          word.each_with_index do |w, index|
            unless w.empty?
              list_users_with_activity(type_of_text: index, slack_client: slack_client, command_channel: command_channel, command_user: command_user, content_attachment: attachment_content(hashmap, w), date: date_requested)
            end
          end
        end
      else
        invalid_data(slack_client, command_channel, command_user)
      end
    else
      invalid_format(slack_client, command_channel, command_user)
    end
    { text: "Jezeli chcesz edytować swoja komende, oto co napisałeś:\n"+
      "#{command[:command]} #{command_text}"
    }
    puts Time.now - time
  end
end

def deleting_zero(str)
  if str[0].equal?("0")
    str[1]
  else
    str
  end
end
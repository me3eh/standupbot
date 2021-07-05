SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/who_doesnt_standup' do |command|
    command_text = command[:text]
    command_team = command[:team_id]
    date_now = Date.today
    team = Team.find_by(team_id: command[:team_id].to_s) || raise("Cannot find team with ID #{command[:team_id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)
    users_and_bots_in_channel = slack_client.conversations_members(channel: command[:channel_id])[:members]
    users_in_channel = []

    if check_command(command_text)
      year, month, day = command_text.split("-")
      if Date.valid_date?(year.to_i, month.to_i, day.to_i)
        users_and_bots_in_channel.each do |u|
          users_in_channel.append(u)
        end
        users_with_morning_standup = Standup_Check.where(date_of_stand: command_text, team: command_text, morning_stand: true)
        users_with_evening_standup = Standup_Check.where(date_of_stand: command_text, team: command_text, evening_stand: true)
        users_with_two_standups = users_with_morning_standup & users_with_evening_standup
        user
      else

      end
    end
  end
end
def check_command(str)
  !!(str =~ /^[2][0-9]{3}-((0[0-9])|(1[1-2]))-(([0-2][0-9])|3[0-1]$)/)
end
require 'date'

instance = SlackRubyBotServer::Service.instance
#sleeps every 55 minutes to not let heroku sleep
instance.every 1.seconds do
  time_now = Time.now
  if time_now.hour.equal?(16)
    date = Date.new(time_now.year, time_now.month, time_now.day)
    Team.where(active: true).each do |team|
      slack_client = Slack::Web::Client.new(token: team.token)
      users = []
      slack_client.users_list[:members].each do |u|
        unless u.is_bot
          users.append(u)
        end
      end
      if Standup_Check.where(team_id: team.team_id, date_of_stand: date).size !=  users.size
        users.each do |user|
            unless user.is_bot
              standup_checks.create(user_id: user.id, team: team.team_id, date_of_stand: date)
            end
          end
        end
        # do something with every team once an hour
    end
  end
end
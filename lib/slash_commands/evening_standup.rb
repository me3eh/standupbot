

SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/evening_standup' do |command|
    team = Team.find_by(team_id: command[:team_id].to_s) ||
      raise("Cannot find team with ID #{command[:team_id]}.")

    slack_client = Slack::Web::Client.new(token: team.token)
    standup = Standup_Check.find_by(user_id: command[:user_id],
                                    date_of_stand: Date.today,
                                    team: command[:team_id])
    json_blocks = Keeper.get_json_evening

    if !standup.nil? && standup.evening_stand
      standup_containing_initial = [
        standup.evening_first,
        standup.evening_second,
        standup.evening_third,
        standup.evening_fourth,
        standup.PRs_and_estimation
      ]
      0.upto(4) do |numbers|
        json_blocks[numbers*3+1][:element] =
          json_blocks[numbers*3+1][:element].merge(
            {
              "initial_value": standup_containing_initial[numbers]
            }
          )
      end
    end
    slack_client.chat_postEphemeral(
      channel: command[:channel_id],
      user: command[:user_id],
      "blocks": json_blocks)
    {text: "Mood check\n"+
      'https://media.discordapp.net/attachments/698625741289685222/'+
          '833280278537437214/image0_5.gif'}
  end
end

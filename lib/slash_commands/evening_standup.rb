SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/evening_standup' do |command|
    include Keeper_pre_standup
    team_id = command[:team_id]
    user_id = command[:user_id]
    standup = Standup_Check.find_by(user_id: user_id,
                                    date_of_stand: Date.today,
                                    team: team_id)
    json_blocks = Keeper_pre_standup.get_json_evening

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
    {
      "blocks": json_blocks
    }
  end
end

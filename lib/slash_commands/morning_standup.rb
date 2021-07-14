SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/morning_standup' do |command|
    include Keeper_pre_standup

    user_id = command[:user_id]
    team_id = command[:team_id]

    standup = Standup_Check.find_by(
      user_id: user_id,
      date_of_stand: Date.today,
      team: team_id
    )

    json_blocks = Keeper_pre_standup.get_json_morning

    if !standup.nil? && standup.morning_stand
      # change if adding new blocks
      standup_containing_initial = [
        standup.morning_first,
        standup.morning_second,
        standup.morning_third,
        standup.morning_fourth
      ]
      0.upto(3) do |numbers|
        json_blocks[numbers*3+1][:element] =
          json_blocks[numbers*3+1][:element].merge(
            { "initial_value": standup_containing_initial[numbers] }
          )
      end

      json_blocks[12][:elements][0] =
        json_blocks[12][:elements][0].merge(
          Keeper_pre_standup.get_initial_radio_button(
            is_stationary: standup.is_stationary)
        ) unless standup.is_stationary.equal?(0)

      json_blocks[11][:elements][0] = json_blocks[11][:elements][0].merge(
        Keeper_pre_standup.get_initial_check_box__morning) if standup.open_for_pp
    end

    {
      "blocks": json_blocks
    }
  end
end


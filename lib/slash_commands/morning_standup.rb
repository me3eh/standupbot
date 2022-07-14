SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/morning_standup' do |command|

    user_id = command[:user_id]
    team_id = command[:team_id]

    standup = Standup_Check.find_by(
      user_id: user_id,
      date_of_stand: Date.today,
      team: team_id
    )

    inputs = if standup.nil?
               nil
             else
               {
                 inputs: [standup.morning_first, standup.morning_second,
                          standup.morning_third, standup.morning_fourth],
                 is_stationary: standup.is_stationary,
                 open_for_pp: standup.open_for_pp
               }
             end
    json_blocks = Forms::MorningStandupForm.call(inputs)

    {
      "blocks": json_blocks
    }
  end
end


module PrepareEveningForm
  extend self

  def call(user_id: , team_id:)

    standup = Standup_Check.find_by(
      user_id: user_id,
      date_of_stand: Date.today,
      team: team_id
    )

    inputs = if standup.nil? || !standup.evening_stand
               nil
             else
               {
                 inputs: [standup.evening_first, standup.evening_second,
                          standup.evening_third, standup.evening_fourth,
                          standup.PRs_and_estimation]
               }
             end
    Forms::EveningStandupForm.call(inputs)
  end
end
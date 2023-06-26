module GetSlackClient
  extend self
  def call(team_id:)
    team = Team.find_by(team_id: team_id) || raise("Cannot find team with ID #{team_id}.")
    Slack::Web::Client.new(token: team.token)
  end
end

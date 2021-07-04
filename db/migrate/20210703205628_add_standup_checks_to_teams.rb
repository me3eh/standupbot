class AddStandupChecksToTeams < ActiveRecord::Migration[6.0]
  def change
    add_reference :standup_checks, :team
  end
end

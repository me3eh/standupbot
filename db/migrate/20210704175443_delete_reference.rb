class DeleteReference < ActiveRecord::Migration[6.0]
  def change
    remove_column :standup_checks, :team_id
  end
end

class ChangeIsStationaryToPlace < ActiveRecord::Migration[6.0]
  def change
    rename_column :standup_checks, :is_stationary, :place
    rename_column :standup_checks, :PRs_and_estimation, :prs_and_estimation
  end
end

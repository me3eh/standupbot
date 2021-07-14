class AddStandupsToGiveInitialValue < ActiveRecord::Migration[6.0]
  def change
    add_column :standup_checks, :morning_first, :text
    add_column :standup_checks, :morning_second, :text
    add_column :standup_checks, :morning_third, :text
    add_column :standup_checks, :morning_fourth, :text
    add_column :standup_checks, :evening_first, :text
    add_column :standup_checks, :evening_second, :text
    add_column :standup_checks, :evening_third, :text
    add_column :standup_checks, :evening_fourth, :text
    add_column :standup_checks, :PRs_and_estimation, :text
    add_column :standup_checks, :is_stationary, :boolean
    add_column :standup_checks, :open_for_pp, :boolean
  end
end

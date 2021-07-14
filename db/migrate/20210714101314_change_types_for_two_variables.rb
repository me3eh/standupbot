class ChangeTypesForTwoVariables < ActiveRecord::Migration[6.0]
  def change
    remove_column :standup_checks, :open_for_pp, :smallint
    add_column :standup_checks, :open_for_pp, :boolean
    remove_column :standup_checks, :is_stationary, :boolean
    add_column :standup_checks, :is_stationary, :integer, limit: 1
  end
end

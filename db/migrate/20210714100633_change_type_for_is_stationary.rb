class ChangeTypeForIsStationary < ActiveRecord::Migration[6.0]
  def change
    remove_column :standup_checks, :open_for_pp, :boolean
    add_column :standup_checks, :open_for_pp, :smallint
  end
end

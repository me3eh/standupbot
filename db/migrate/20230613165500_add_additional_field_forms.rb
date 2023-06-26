class AddAdditionalFieldForms < ActiveRecord::Migration[6.0]
  def change
    add_column :standup_checks, :morning_fifth, :text
    add_column :standup_checks, :morning_sixth, :text
    add_column :standup_checks, :morning_seventh, :text
    add_column :standup_checks, :morning_eighth, :text
  end
end

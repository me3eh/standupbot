class AddAdditionalFieldForms < ActiveRecord::Migration[6.0]
  def change
    add_column :standup_checks, :fifth_input, :text
    add_column :standup_checks, :sixth_input, :text
    add_column :standup_checks, :seventh_input, :text
    add_column :standup_checks, :eighth_input, :text
  end
end

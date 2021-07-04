class DeleteReferenceAndForeignKey < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :standup_checks, :teams
    add_column :standup_checks, :team, :string
  end
end

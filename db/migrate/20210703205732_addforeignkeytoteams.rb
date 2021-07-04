class Addforeignkeytoteams < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :standup_checks, :teams
  end
end

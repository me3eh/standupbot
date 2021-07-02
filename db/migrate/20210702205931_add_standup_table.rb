class AddStandupTable < ActiveRecord::Migration[6.0]
  def change
    create_table :standup_checks, force: true do |t|
      t.string :user_id, null: false
      t.boolean :morning_stand, default: false
      t.boolean :evening_stand, default: false
      t.date :date_of_stand
      t.timestamps
    end
  end
end

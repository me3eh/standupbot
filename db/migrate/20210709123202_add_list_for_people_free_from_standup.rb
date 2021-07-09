class AddListForPeopleFreeFromStandup < ActiveRecord::Migration[6.0]
  def change
    create_table :free_from_standups, force: true do |t|
      t.string :user_id, null: false
      t.date :date_of_beginning
      t.date :date_of_ending
      t.string :reason
      t.timestamps
    end
  end
end

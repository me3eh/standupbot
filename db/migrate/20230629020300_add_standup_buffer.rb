# frozen_string_literal: true

class AddStandupBuffer < ActiveRecord::Migration[6.0]
  def change
    create_table :standup_buffers do |t|
      t.string :team_id
      t.string :user_id
      t.string :message_timestamp
      t.timestamps
    end
  end
end

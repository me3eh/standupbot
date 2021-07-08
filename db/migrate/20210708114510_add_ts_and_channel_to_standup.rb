class AddTsAndChannelToStandup < ActiveRecord::Migration[6.0]
  def change
    add_column :standup_checks, :ts_of_message, :string
    add_column :standup_checks, :channel_of_message, :string
  end
end

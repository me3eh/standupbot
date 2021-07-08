class AddTsAndChannelToStandupToDivideThemIntoMorningAndEvening < ActiveRecord::Migration[6.0]
  def change
    add_column :standup_checks, :ts_of_message_evening, :string
    add_column :standup_checks, :channel_of_message_evening, :string
    rename_column :standup_checks, :channel_of_message, :channel_of_message_morning
    rename_column :standup_checks, :ts_of_message, :ts_of_message_morning
  end
end

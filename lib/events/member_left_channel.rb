
SlackRubyBotServer::Events.configure do |config|
  config.on :event, 'event_callback', 'member_left_channel' do |event|
    puts event
    eventx2 = event[:event]
    puts $everything_needed.delete_member_from_list_members_in_channel(
      channel_id: eventx2[:channel],
      user_id: eventx2[:user]
    )
  end
end
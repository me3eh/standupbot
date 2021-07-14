
SlackRubyBotServer::Events.configure do |config|
  config.on :event, 'event_callback', 'member_left_channel' do |event|
    event.logger.info "Someone left the channel"
    $everything_needed.update_list_members_in_channel(
      channel_id: event[:event][:channel],
      team_id: event[:team_id]
    )
  end
end
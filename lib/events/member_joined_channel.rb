
SlackRubyBotServer::Events.configure do |config|
  config.on :event, 'event_callback', 'member_joined_channel' do |event|
    event.logger.info "Someone joined the channel"
    team_id = event[:team_id]
    $everything_needed.update_list_members_in_channel(
      team_id: team_id,
      channel_id: event[:event][:channel]
    ) unless $everything_needed.is_bot(user_id: event[:event][:user],
                                       team_id: team_id)
  end
end
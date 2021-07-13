
SlackRubyBotServer::Events.configure do |config|
  config.on :event, 'event_callback', 'member_joined_channel' do |event|
    # event.logger.info "Edited member in hash"
    team_id = event[:team_id]
    user_id = event[:event][:user]
    puts user_id
    puts $everything_needed.add_member_to_list_members_in_channel(
      team_id: team_id,
      channel_id: event[:event][:channel],
      user_id: user_id
    ) unless $everything_needed.get_slack_client(team_id: team_id
      ).users_info(
        user: user_id)[:user][:is_bot]
  end
end
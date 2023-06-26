SlackRubyBotServer::Events.configure do |config|
  config.on :event, 'event_callback', 'user_change' do |event|
    event.logger.info 'Edited member in hash'
    needed_info = event[:event][:user]
    $everything_needed.change_info_about_user(team_id: needed_info[:team_id],
                                              user_id: needed_info[:id],
                                              real_name: needed_info[:real_name],
                                              pic: needed_info[:profile][:image_192])
  end
end

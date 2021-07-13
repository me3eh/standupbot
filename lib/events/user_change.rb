SlackRubyBotServer::Events.configure do |config|
  config.on :event, 'event_callback', 'user_change' do |event|
    event.logger.info "Edited member in hash"
    info_about_user = event[:event][:user]
    { ok: true }
    $everything_needed.change_info_about_user(
      user_id: info_about_user[:id],
      real_name: info_about_user[:profile][:real_name],
        pic: info_about_user[:profile][:image_192],
      team_id: info_about_user[:team_id]
    )
  end
end
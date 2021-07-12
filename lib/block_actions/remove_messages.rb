SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'deleting' do |action|
    puts action
  end
end
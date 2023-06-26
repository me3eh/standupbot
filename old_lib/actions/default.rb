SlackRubyBotServer::Events.configure do |config|
  config.on :action do |action|
    action.logger.info "Received #{action[:payload][:type]}."
    action.logger.info action
    nil
  end
end
SlackRubyBotServer::Events.configure do |config|
  config.on :interactive_message do |action|
    action.logger.info "Received #{action[:payload][:type]}."
    nil
  end
end

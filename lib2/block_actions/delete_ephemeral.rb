SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'delete_ephemeral' do |action|
    Services::HideMessage.call(action[:payload][:response_url])
  end
end

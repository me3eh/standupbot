SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'interactive_message', 'delete_ephemeral' do |action|
    Faraday.post(action[:payload][:response_url], {
      delete_original: true
    }.to_json, 'Content-Type' => 'application/json')
  end
end
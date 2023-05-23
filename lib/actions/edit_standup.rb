# frozen_string_literal: true

SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'message_action', 'edit_standup' do |action|
    pp action
  end
end

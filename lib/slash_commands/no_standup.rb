SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/no_standup' do |command|
    include Keeper_excusals
    {
      "text": "Wybierz swoją opcję",
      "attachments": Keeper_excusals.attachment_for_main_screen
    }
  end
end
SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/excusal' do
    include Keeper_excusals
    {
      "text": "Wybierz swoją opcję",
      "attachments": Keeper_excusals.attachment_for_main_screen
    }
  end
end
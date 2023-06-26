SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/evening_standup1' do |command|
    json_blocks = Jsons::EveningForm.new.call(user_id: command[:user_id],
                                              team_id: command[:team_id])
    {
       blocks: json_blocks
    }
  end
end

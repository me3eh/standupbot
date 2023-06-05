SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/morning_standup1' do |command|
  #binding.pry
    json_blocks = PrepareMorningForm.call(user_id: command[:user_id],
                                          team_id: command[:team_id])
    {
      "blocks": json_blocks
    }
  end
end


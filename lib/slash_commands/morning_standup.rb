SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/morning_standup' do |command|

    json_blocks = PrepareMorningForm.call(user_id: command[:user_id],
                                          team_id: command[:team_id])
    {
      "blocks": json_blocks
    }
  end
end


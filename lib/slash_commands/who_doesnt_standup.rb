SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/who_doesnt_standup' do |command|
    command_text = command[:text]
    time_now = Time.now
    if check_command(command_text)
      puts Date.valid_date?(test[0].to_i, test[1].to_i, test[2].to_i)       #=> false

    else

    end
  end
end

def check_command(str)
  !!(str =~ /^[2][0-9]{3}-((0[0-9])|(1[1-2]))-(([0-2][0-9])|3[0-1]$)/)
end
SlackRubyBotServer::Events.configure do |config|
  config.on :command do |command|
    command.logger.info "Received #{command[:command]}."
    nil
  end
end

def contains_number(str, number)
  !!(str =~ /#{number}/)
end
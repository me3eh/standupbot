SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'interactive_message', 'choice_for_excusal' do |action|
    include Keeper_excusals
    action_payload = action[:payload]
    user_id = action_payload[:user][:id]
    team_id = action_payload[:team][:id]
    choice = action_payload[:actions][0][:value].split('-')
    case choice[0]
    when 'add'
      Keeper_excusals.add_option__block(today_now: Date.today, user_id: user_id)
    # when "delete"
    #   Keeper_excusals.delete_option__block
    when 'list'
      Keeper_excusals.list_block(team_id: team_id, page: choice[1].to_i)
    else
      { text: 'idk, coś się stało' }
    end
  end
end

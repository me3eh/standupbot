SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'remove_excusal' do |action|
    action_payload = action[:payload]
    response_url = action_payload[:response_url]
    arguments_from_form = action_payload[:state][:values]
    choice = ''
    arguments_from_form.each do |arg|
      choice = arg[1][:static_select][:selected_option][:value]
      choice = choice.nil? ? -1 : choice
    end
    if choice == -1
      Faraday.post(response_url, {
        response_type: 'ephemeral',
        "text": "Nie wybrałeś numeru",
      }.to_json, 'Content-Type' => 'application/json')
    else
      Faraday.post(response_url, {
        response_type: 'ephemeral',
        "text": "Pomyślnie usunięto dane zwolnienie",
      }.to_json, 'Content-Type' => 'application/json')
      excusal = Free_From_Standup.find(choice)
      excusal.destroy unless excusal.nil?
    end
  end
end

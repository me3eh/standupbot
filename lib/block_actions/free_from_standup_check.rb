SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'actionId-3' do |action|
    action_payload = action[:payload]
    puts action_payload
    response_url = action_payload[:response_url]
    arguments_from_form = action_payload[:state][:values]

    # Faraday.post(response_url, {
    #   response_type: 'ephemeral',
    #   "text": "Już odznaczone :white_check_mark:",
    # }.to_json, 'Content-Type' => 'application/json')

    # first and second elements in response are date and the
    # third one is user for whom is day free from standup

    response = []
    truth = true
    arguments_from_form.each do |argument_for_user|
      argument_for_user[1].each_with_index do |variables, index|
        if index.equal?(2)
          response.append variables[1][:selected_user]
        else
          response.append truth ?
                            variables[1][:selected_date] :
                            variables[1][:value]
          truth = !truth unless index.equal?(0)
        end
      end
    end
    if response[0] > response[1]
      Faraday.post(response_url, {
        response_type: 'ephemeral',
        "text": "Pierwsza data jest większa",
      }.to_json, 'Content-Type' => 'application/json')
    else
      Free_From_Standup.create(date_of_beginning: response[0],
                               date_of_ending: response[1],
                               user_id: response[2],
                               reason: response[3])
      Faraday.post(response_url, {
        response_type: 'ephemeral',
        "text": "Już odznaczone :white_check_mark:",
      }.to_json, 'Content-Type' => 'application/json')

    end

  end
end
SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'message_action', 'serin' do |action|

    Faraday.post(action[:payload][:response_url], {
      response_type: 'ephemeral',
    "blocks":[
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": ":serin: Rozwiń załącznik  :nires:"
        }
      },
      {
        "type": "image",
        "image_url": "https://cdn.discordapp.com/attachments/766045866724163647/862998404031578112/ezgif.com-gif-maker4.gif",
        "alt_text": "inspiration"
      }
    ],
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }
  end
end
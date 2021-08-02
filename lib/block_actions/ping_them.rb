SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'ping_them' do |action|
    action_payload = action[:payload]
    team_id = action_payload[:user][:team_id]
    channel_id = action_payload[:container][:channel_id]
    blocks = []

    Faraday.post(action_payload[:response_url], {
      response_type: "ephemeral",
      text: "Juz sie robi szefie"
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }

    $everything_needed.array_of_members.each do |member|
      pic = $everything_needed.get_info_about_user(team_id: team_id,
                                           user_id: member)[1]
      blocks.append( ping_users(pic: pic, user_id: member) )
    end
    $everything_needed.get_slack_client(team_id: team_id).
      chat_postMessage(channel: channel_id,
                       blocks: blocks)
  end
end

def ping_users(pic:,  user_id:)
{
  "type": "context",
  "elements": [
    {
      "type": "image",
      "image_url": pic,
      "alt_text": 'profile_picture'
    },
    {
      "type": "mrkdwn",
      "text": "- <@#{user_id}>"
    }
  ]
}
end
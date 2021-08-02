SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/ping_present' do |command|
    include Keeper_excusals
    team_id = command[:team_id]
    all_members_in_channel = $everything_needed.get_list_members_in_channel(team_id: team_id,
                                                          channel_id: command[:channel_id])
    people_remotely = Standup_Check.where(is_stationary: 2,
                                          team: team_id).pluck(:user_id)
    people_stationary = all_members_in_channel - people_remotely
    $everything_needed.array_of_members = people_stationary
    list_in_conversation = []
    people_stationary.each do |member|
      name, pic = $everything_needed.get_info_about_user( team_id: team_id,
                                                          user_id: member )
      list_in_conversation.append( one_line_mrkdown(name, pic) )
    end
    list_in_conversation.append( button )
    {
      "text": "Not gonna show",
      "blocks": list_in_conversation
    }
  end
end

def one_line_mrkdown(name, pic)
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
      "text": name
    }
  ]
}
end

def button
  {
    "type": "actions",
    "elements": [
      {
        "type": "button",
        "text": {
          "type": "plain_text",
          "text": "Spinguj ich",
        },
        "value": "ping_them",
        "action_id": "ping_them",
        "style": "danger"
      }
    ]
  }
end
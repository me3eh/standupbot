
SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/morning_standup' do |command|
    # team = Team.find_by(team_id: command[:team_id].to_s) ||
    #   raise("Cannot find team with ID #{command[:team_id]}.")
    # slack_client = Slack::Web::Client.new(token: team.token)
    user_id = command[:user_id]
    team_id = command[:team_id]
    slack_client = $everything_needed.get_slack_client(team_id: team_id)

    standup = Standup_Check.find_by(user_id: user_id,
                                    date_of_stand: Date.today,
                                    team: team_id)
    json_blocks = Keeper.get_json_morning
    if !standup.nil? && standup.morning_stand
      # change if adding new blocks
      standup_containing_initial = [
        standup.morning_first,
        standup.morning_second,
        standup.morning_third,
        standup.morning_fourth
      ]
      0.upto(3) do |numbers|
        json_blocks[numbers*3+1][:element] =
          json_blocks[numbers*3+1][:element].merge(
            {
              "initial_value": standup_containing_initial[numbers]
            }
          )
      end

      json_blocks[12][:elements][0] =
        json_blocks[12][:elements][0].merge(get_initial_radio_button(
          is_stationary: standup.is_stationary)
        ) unless standup.is_stationary.equal?(0)

      json_blocks[11][:elements][0] = json_blocks[11][:elements][0].merge(
        Keeper.get_initial_check_box__morning) if standup.open_for_pp
    end

    slack_client.chat_postEphemeral(
      channel: command[:channel_id],
      user: user_id,
      "blocks": json_blocks
    )
    {text: "Mood_check:\n"+"https://theuselessweb.com/"}
  end
end

def get_initial_radio_button(is_stationary:)
  text, value = get_place_of_working(is_stationary: is_stationary)
   {
     "initial_option" => {
       "text": {
        "type": "plain_text",
        "text": text,
        "emoji": true
        },
     "value": value
      }
   }
end

def get_place_of_working(is_stationary:)
  is_stationary.equal?(1) ?
    %w[Stacjonarnie stationary] :
    %w[Zdalnie remotely]
end
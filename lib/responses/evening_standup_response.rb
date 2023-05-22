# frozen_string_literal: true

SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'submit_evening_standup' do |params|
    first_input =  params.dig("payload", "state", "values", "first_input", "first_input", "value")
    second_input =  params.dig("payload", "state", "values", "second_input", "second_input", "value")
    third_input =  params.dig("payload", "state", "values", "third_input", "third_input", "value")
    fourth_input =  params.dig("payload", "state", "values", "fourth_input", "fourth_input", "value")
    pp fourth_input

    Faraday.post(params.dig(:payload, :response_url), {
      text: "Dzięki za przeslanie",
    }.to_json, 'Content-Type' => 'application/json')
    { ok: true }

    pp params.dig(:payload, :user, :team_id)
    team = Team.find_by(team_id: params.dig(:payload, :user, :team_id)) || raise("Cannot find team with ID 1.")
    slack_client = Slack::Web::Client.new( token: team.token )

    slack_client.chat_postMessage(
      channel: params.dig(:payload, :container, :channel_id),
      "blocks": EveningStandupMessage::MessageJson.new.call,
      as_user: true,
      )
  end
end

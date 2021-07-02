require 'faraday'
require 'slack-ruby-block-kit'
require 'json'
SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/example' do |command|
    command.logger.info 'lell'

    a_prebuilt_block = Slack::BlockKit::Layout::Section.new
    text = Slack::BlockKit::Composition::Mrkdwn.new(text: ':wave: *hello*')
    an_image = Slack::BlockKit::Element::Image.new(image_url: 'https://git.io/fjDW8', alt_text: 'a picture')
    a_prebuilt_block.accessorise(an_image)
    a_prebuilt_block.text = text

    blocks = Slack::BlockKit.blocks do |b|
      b.section do |s|
        s.plain_text(text: 'Some plain text message!')
        s.button(text: 'A button that is important', style: 'primary', action_id: 'id')
      end

      b.divider

      b.context do |c|
        c.mrkdwn(text: '_some italicised text for context_')
      end

      b.append(a_prebuilt_block)
    end

    webhook_url = command[:response_url].to_s
    body = { blocks: blocks.as_json, text: 'New block message!' }

    response = Faraday.post(
      webhook_url,
      body.to_json,
      'Content-Type' => 'application/json'
    )
    { ok: true }
  end
end

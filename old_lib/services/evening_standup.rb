module EveningStandup
  extend self
  FIELDS = ['1. Co ukończone?',
            '2. Co nieukończone?',
            '3. Blockery podczas dnia',
            '4. Jakie wnioski?',
            "PR'ki, tickeciki itd."].freeze

  VALUES = %i[first_input
              second_input
              third_input
              fourth_input
              prs].freeze
  def post_or_edit(slack_client:, channel_id:, text_for_header:, responds:, pic:, username:, ts: nil)
    blocks = [Jsons::Header.call(text: text_for_header)]
    color = Constants::Forms::COLOR_FOR_EVENING_STANDUP
    attachments = Jsons::Attachments.call(fields: fields(responds), footer: footer, color: color, pic: pic)

    if ts.nil?
      slack_client.chat_postMessage(
        channel: channel_id,
        blocks: blocks,
        attachments: attachments,
        icon_url: pic,
        username: username
      )
    else
      slack_client.chat_update(
        channel: channel_id,
        ts: ts,
        blocks: blocks,
        attachments: attachments,
        icon_url: pic,
        username: username
      )
    end
  end

  private

  def fields(responds)
    fields_array = []
    FIELDS.each.with_index do |field, index|
      fields_array << Jsons::Field.call(title: field, value: responds[VALUES[index]])
    end
    fields_array
  end
end

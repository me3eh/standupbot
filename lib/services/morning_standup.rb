module MorningStandup
  extend self
  FIELDS = ["1. Zadania na dziś",
            "2. Blockery",
            "3. Pomoc?",
            "4. Kompan do pomocy?"].freeze
  VALUES = [:first_input,
            :second_input,
            :third_input,
            :fourth_input].freeze
  def post_or_edit(ts: nil, slack_client:, channel_id:, text_for_header:, responds:, pic:, username:)
    blocks = [ Jsons::Header.call(text: text_for_header)]
    footer = " #{place(responds[:place])} \t #{open_for_pp(responds[:open_for_pp])}"
    color = Constants::Forms::COLOR_FOR_MORNING_STANDUP
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

  def place(responds)
    case responds
    when Constants::Forms::SOMEWHERE_FAR_AWAY
      "#idk, gdzieś w Mońkach"
    when Constants::Forms::STATIONARY
      "#stacjonarnie"
    when Constants::Forms::REMOTELY
      "#zdalnie"
    else
      "co ty zaznaczyles? :O"
    end
  end

  def open_for_pp(checkbox_checked)
    checkbox_checked ? "#chce sam :flushed:" : "#daj mnie kogoś"
  end
end
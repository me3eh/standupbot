module MorningStandup
  extend self
  def post_new(slack_client:, channel_id:, text_for_header:, responds:, pic:)
    slack_client.chat_postMessage(
      channel: channel_id,
      "blocks": [
        Jsons::Header.call(text: text_for_header)
      ],
      "attachments": [
        fields:[
          Jsons::Field.call(title: "1. Zadania na dziś", value: responds[:first_input]),
          Jsons::Field.call(title: "2. Blockery", value: responds[:second_input]),
          Jsons::Field.call(title: "3. Pomoc?", value: responds[:third_input]),
          Jsons::Field.call(title: "4. Kompan do pomocy?", value: responds[:fourth_input]),
        ],
        footer: " #{place(responds[:radio_button])} \t #{open_for_pp(responds[:checkbox])}",
        color: Constants::Forms::COLOR_FOR_MORNING_STANDUP,
        thumb_url: pic,
      ],
      as_user: true,
      )
  end

  def edit(ts:, slack_client:, channel_id:, text_for_header:, responds:, pic:)
    slack_client.chat_update(
      channel: channel_id,
      ts: ts,
      "blocks": [
        Jsons::Header.call(text: text_for_header)
      ],
      "attachments": [
        fields:[
          Jsons::Field.call(title: "1. Zadania na dziś", value: responds[:first_input]),
          Jsons::Field.call(title: "2. Blockery", value: responds[:second_input]),
          Jsons::Field.call(title: "3. Pomoc?", value: responds[:third_input]),
          Jsons::Field.call(title: "4. Kompan do pomocy?", value: responds[:fourth_input]),
        ],
        footer: " #{place(responds[:radio_button])} \t #{open_for_pp(responds[:checkbox])}",
        color: Constants::Forms::COLOR_FOR_MORNING_STANDUP,
        thumb_url: pic,
      ],
      as_user: true,
      )
  end

  private

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
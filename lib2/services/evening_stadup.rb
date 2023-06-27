module Services
  class EveningStandup
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

    def call(slack_client:, channel_id:, text_for_header:, responds:, pic:, username:, ts: nil)
      blocks = []
      blocks << Jsons::Header.call(text: "#{text_for_header} #{username}")
      blocks << Jsons::Image.call(pic: pic, username: username)
      color = '#1B4D3E'
      attachments = Jsons::Attachments.call(fields: fields(responds), color: color, pic: pic)

      slack_client.chat_postMessage(
        channel: channel_id,
        blocks: blocks,
        attachments: attachments,
        # icon_url: pic,
        username: username
      )
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
end

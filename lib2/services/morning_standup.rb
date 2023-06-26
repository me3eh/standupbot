# module Services

#     class MorningStandup
#         FIELDS = ["1. Zadania na dziś",
#                   "2. Blockery",
#                   "3. Pomoc?",
#                   "4. Kompan do pomocy?",
#                   "5. Ostatni problem?",
#                   "6. Jakie wzorce?",
#                   "7. Link do ticketów?",
#                   "8. Gemy?"].freeze
#         VALUES = [:first_input,
#                   :second_input,
#                   :third_input,
#                   :fourth_input,
#                   :fifth_input,
#                   :sixth_input,
#                   :seventh_input,
#                   :eighth_input].freeze

#         def post(ts: nil, slack_client:, channel_id:, text_for_header:, responds:, pic:, username:)
#             blocks= [Jsons::Header.call(text: text_for_header)]
#             footer = " #{place(responds[:place])} \t #{open_for_pp(responds[:open_for_pp])}"
#             color= "#bfff00"
#             attachments = Jsons::Attachments.call(fields: fields(responds), footer: footer, color: color, pic: pic)

#             slack_client.chat_postMessage(
#                 channel: channel_id,
#                 blocks: blocks,
#                 attachments: attachments,
#                 icon_url: pic, 
#                 username: username
#             )
#         end
#     end

#         private

#     def fields(responds)
#         fields_array = []
#         FIELDS.each.with_index do |field, index|
#         fields_array << Jsons::Field.call(title: field, value: responds[VALUES[index]])
#         end
#         fields_array
#     end

#     def place(responds)
#         case responds
#         when nil
#         "#idk, gdzieś w Mońkach"
#         when 0
#         "#stacjonarnie"
#         when 1
#         "#zdalnie"
#         else
#         "co ty zaznaczyles? :O"
#         end
#     end

#     def open_for_pp(checkbox_checked)
#         checkbox_checked ? "#chce sam :flushed:" : "#daj mnie kogoś"
#     end
    
# end

module Services
    class MorningStandup
      FIELDS = ["1. Zadania na dziś",
                "2. Blockery",
                "3. Pomoc?",
                "4. Kompan do pomocy?",
                "5. Ostatni problem?",
                "6. Jakie wzorce?",
                "7. Link do ticketów?",
                "8. Gemy?"].freeze
      VALUES = [:first_input,
                :second_input,
                :third_input,
                :fourth_input,
                :fifth_input,
                :sixth_input,
                :seventh_input,
                :eighth_input].freeze
  
      def call(ts: nil, slack_client:, channel_id:, text_for_header:, responds:, pic:, username:)
        blocks = [Jsons::Header.call(text: text_for_header)]
        footer = " #{place(responds[:place])} \t #{open_for_pp(responds[:open_for_pp])}"
        color = "#bfff00"
        attachments = Jsons::Attachments.call(fields: fields(responds), footer: footer, color: color, pic: pic)
  
        slack_client.chat_postMessage(
          channel: channel_id,
          blocks: blocks,
          attachments: attachments,
          icon_url: pic,
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
  
      def place(responds)
        case responds
        when nil
          "#idk, gdzieś w Mońkach"
        when 0
          "#stacjonarnie"
        when 1
          "#zdalnie"
        else
          "co ty zaznaczyles? :O"
        end
      end
  
      def open_for_pp(checkbox_checked)
        checkbox_checked ? "#chce sam :flushed:" : "#daj mnie kogoś"
      end
    end
  end
  
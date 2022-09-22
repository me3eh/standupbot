
#frozen string
module Forms
  module EveningStandupForm
    extend self

    TEXTS_FOR_INPUTS = [
      "1. Co udało ci sie dzisiaj skończyć?",
      "2. Które zadań nie zostały zakończone i na jakim etapie dzisiaj je pozostawiasz ? " +
        "(pamiętałeś żeby wypchnąć je do repo?)",
      "3. Pojawiły się jakieś blockery?",
      "4. Czego nowego się dziś nauczyłeś / dowiedziałeś ? A jeśli niczego / "+
        "to czego w danym temacie chciałbyś się dowiedzieć ? Daj nam sobie pomóc",
      "Tutaj wrzuć swoje tickety/pry oraz czas ich wykonania - spokojnie, opcjonalne"
    ].freeze

    def call(previous_inputs)
      json = []
      json << Jsons::Header.call(text: "Wieczorny  Standup :city_sunset:")
      json << merged_inputs(previous_inputs)

      elements_in_action_block = action_block(previous_inputs)

      json << Jsons::Action.call(elements_in_action_block)

      json.flatten
    end

    private

    def action_block(previous_inputs)
      elements = []

      elements << Jsons::Button.call(color: "green",
                                     text: Constants::Forms.text_for_submit(input: previous_inputs),
                                     value: "save",
                                     id_of_action: "evening_saving")
      elements << Jsons::Button.call(text: "Zapisz, usuwając poprzednią",
                                     value: "delete_and_save",
                                     id_of_action: "evening_deleting_and_saving") if previous_inputs.present?
      elements
    end

    def merged_inputs(previous_inputs)
      json_with_inputs = []
      TEXTS_FOR_INPUTS.each.with_index do |text, index|

        2.times do
          json_with_inputs << Jsons::Divider.call
        end if index != 0

        json_with_inputs << Jsons::Input.call( input_initial_options(previous_inputs, symbol: :inputs, index: index),
                                               id: index, is_multiline: true, text_for_label: text)

      end
      json_with_inputs
    end

    def input_initial_options(previous_inputs, index:nil ,symbol:)
      return nil if previous_inputs.nil?

      previous_inputs.dig(symbol, index)
    end
  end
end
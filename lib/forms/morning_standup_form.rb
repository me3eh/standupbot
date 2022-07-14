#frozen string
module Forms
  module MorningStandupForm
    extend self

    TEXTS_FOR_INPUTS = [
      "1. Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?",
      "2. Jakie widzisz zagrożenia i blockery w powyższej liście?",
      "3. Czy w któryms z powyższych tematów chciałbyś otrzymać pomoc?",
      "4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu / konsultacji / "+
        "podzielenia się wiedzą doświadczeniami ?"
    ].freeze

    def call(previous)
      json = []
      json << Jsons::Header.call(text: "Poranny Standup")
      json << merged_inputs(previous)

      elements_in_action_block = action_block(previous)

      json << Jsons::Action.call(elements_in_action_block)

      json.flatten
    end

    private

    def action_block(previous)
      elements = []

      elements << Jsons::RadioButtons.call(radio_button_options, previous[:place])

      elements << Jsons::Checkbox.call(checkbox_options, previous[:open_for_pp])
      elements << Jsons::Button.call(color: "green", text: text_for_submit(previous), value: "save", id_of_action: "morning_saving")

      elements << Jsons::Button.call(text: "Zapisz, usuwając poprzednią",
                                     value: "delete_and_save",
                                     id_of_action: "morning_deleting_and_saving") if previous.present?
      elements
    end

    def text_for_submit(previous)
      previous.present? ? "Edytuj poprzedni" : "Potwierdź"
    end

    def merged_inputs(inputs)
      json_with_inputs = []
      TEXTS_FOR_INPUTS.each.with_index do |text, index|

        2.times do
          json_with_inputs << Jsons::Divider.call
        end if index != 0

        json_with_inputs << Jsons::Input.call(inputs[:inputs][index], id: index, is_multiline: true, text_for_label: text)
      end
      json_with_inputs
    end

    def radio_button_options
      [
        Jsons::FormOption.call(text: "Stacjonarnie", value: "stationary"),
        Jsons::FormOption.call(text: "Zdalnie", value: "remotely")
      ]
    end

    def checkbox_options
      [
        Jsons::CheckboxOption.call_with_description(text: "Open for PP",
                                                    description: "Zaznaczenie na własną odpowiedzialność",
                                                    value: "checked")
      ]
    end
  end
end
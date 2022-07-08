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

    def call
      json = []
      json << Jsons::Header.call(text: "Poranny Standup")
      json << merged_inputs
      json << [
        Jsons::RadioButtons.call(radio_button_options),
        Jsons::Checkbox.call(checkbox_options),
        Jsons::SubmitButton.call(text: "Potwierdź", value: "click_me_123", id_of_action: "actionId-0")
      ]
      json.flatten
    end

    private

    def merged_inputs
      json_with_inputs = []
      TEXTS_FOR_INPUTS.each.with_index do |text, index|

        2.times do
          json_with_inputs << Jsons::Divider.call
        end if index != 0

        json_with_inputs << Jsons::Input.call(is_multiline: true, text_for_label: text)
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
        Jsons::FormOption.call(text: "Open for PP*", description: "Zaznaczenie na własną odpowiedzialność", value: "checked"),
      ]
    end
  end
end
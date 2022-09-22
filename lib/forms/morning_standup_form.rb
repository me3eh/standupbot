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

    def call(previous_inputs)
      json = []
      json << Jsons::Header.call(text: "Poranny Standup :city_sunrise:")
      json << merged_inputs(previous_inputs)

      elements_in_action_block = action_block(previous_inputs)

      json << Jsons::Action.call(elements_in_action_block)

      json.flatten
    end

    private

    def action_block(previous_inputs)
      elements = []

      elements << Jsons::RadioButtons.call(radio_button_options,
                                           input_initial_options(previous_inputs, symbol: :place))
      elements << Jsons::Checkbox.call(checkbox_options, input_initial_options(previous_inputs, symbol: :open_for_pp))
      elements << Jsons::Button.call(color: "green",
                                     text: Constants::Forms.text_for_submit(input: previous_inputs),
                                     value: "save",
                                     id_of_action: "morning_saving")
      elements << Jsons::Button.call(text: "Zapisz, usuwając poprzednią",
                                     value: "delete_and_save",
                                     id_of_action: "morning_deleting_and_saving") if previous_inputs.present?
      elements << Jsons::Button.call(color: "red",
                                     text: "Zamknij formularz",
                                     value: "delete_and_save",
                                     id_of_action: "delete_ephemeral")

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

    def input_initial_options(previous_inputs, index:nil ,symbol:)
      return nil if previous_inputs.nil?

      return previous_inputs.dig(symbol) - 1 if symbol == :place
      return previous_inputs.dig(symbol) if index.nil?

      previous_inputs.dig(symbol, index)
    end
  end
end
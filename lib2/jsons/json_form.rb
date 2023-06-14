module Jsons
  class JsonForm

    def initialize; end

    def call(user_id:, team_id:)
      blocks = []

      blocks << Header::call(text: "Poranny Standup!")
      blocks << Input::call(label_text: "1. Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?", value_id: "first_input")
      blocks << Input::call(label_text: "2. Jakie widzisz zagrożenia i blokery w powyższej liście?", value_id: "second_input")
      blocks << Input::call(label_text: "3. Czy w którymś z powyższych tematów chciałbyś otrzymać pomoc?", value_id: "third_input")
      blocks << Input.call(
        label_text: "4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu / konsultacji / " + 
        " podzielenia się wiedzą i doświadczeniem?",
        value_id: "fourth_input"
      )      
      blocks << RadioButton::call(value_id: "radio_input")
      blocks << CheckBox::call(value_id: "checkbox_input")
      blocks << Devider::call
      blocks << Input::call(label_text: "5. Jaki problem ostatnio rozwiązałeś?", value_id: "fifth_input")
      blocks << Input::call(label_text: "6. Jakich użyłeś w tym celu wzorców?", value_id: "sixth_input")
      blocks << Input::call(label_text: "7. Link do ticketów?", value_id: "seventh_input")
      blocks << Input::call(label_text: "8. Jakie gemy wykorzystałeś?", value_id: "eighth_input")
      blocks << Devider::call
      blocks << ActionBlock::call

      { blocks: blocks }

    end
  end
end







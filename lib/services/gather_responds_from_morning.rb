class GatherRespondsFromMorning
  def call(responds_from_form)
    responds = {}
    inputs = [:first_input, :second_input, :third_input, :fourth_input]
    inputs.each.with_index do |input, index|
      response[input] = responds_from_form[index.to_s][index.to_s]["value"]
    end
    responds[:radio_button] = responds_from_form["action"]["radio_choice"]["selected_option"]["value"]
    checkbox_value = responds_from_form["action"]["checkbox_choice"]["selected_options"].first

    responds[:checkbox] = if checkbox_value.nil?
                            Constants::Forms::NOT_REALLY_KEEN_FOR_PP
                          else
                            Constants::Forms::OPEN_FOR_PP
                          end
    responds
  end
end
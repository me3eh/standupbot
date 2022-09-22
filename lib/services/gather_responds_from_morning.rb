module GatherRespondsFromMorning
  extend self

  def call(responds_from_form)
    responds = {}

    inputs = [:first_input, :second_input, :third_input, :fourth_input]
    inputs.each.with_index do |input, index|
      responds[input] = input_field_value(responds_from_form[index.to_s][index.to_s]["value"])
    end
    responds[:place] = radio_buttons_option(responds_from_form["action"]["radio_choice"]["selected_option"])
    responds[:open_for_pp] = checkbox_checked?(responds_from_form["action"]["checkbox_choice"]["selected_options"])
    responds
  end

  private

  def input_field_value(responds)
    return Constants::Forms::EMOJI_FOR_MORNING if responds.nil? || responds.strip.empty?
    responds
  end

  def checkbox_checked?(respond)
    respond.first.present?
  end

  def radio_buttons_option(respond)
    return Constants::Forms::SOMEWHERE_FAR_AWAY if respond.nil?

    if respond["value"] == "remotely"
      Constants::Forms::REMOTELY
    else
      Constants::Forms::STATIONARY
    end
  end
end
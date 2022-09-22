module GatherRespondsFromEvening
  extend self

  def call(responds_from_form)
    responds = {}

    inputs = [:first_input, :second_input, :third_input, :fourth_input, :prs]
    inputs.each.with_index do |input, index|
      responds[input] = input_field_value(responds_from_form[index.to_s][index.to_s]["value"])
    end
    responds
  end

  private

  def input_field_value(respond)
    return Constants::Forms::EMOJI_FOR_EVENING if respond.nil? || respond.strip.empty?
    respond
  end
end
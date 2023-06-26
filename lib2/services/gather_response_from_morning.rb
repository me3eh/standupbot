module Services
  class GatherRespondsFromMorning
    def initialize(params)
      @params = params
    end

    def call
      responds = {}
      inputs = %i[first_input second_input third_input fourth_input fifth_input sixth_input
                  seventh_input eighth_input]

      inputs.each do |input|
        responds[input] = @params.dig(:payload, :state, :values, input, input, :value)
      end

      responds[:place] =
        convert_place(@params.dig(:payload, :state, :values, :radio_input, :radio_input, :selected_option, :value))
      responds[:open_for_pp] =
        convert_open_for_pp(@params.dig(:payload, :state, :values, :checkbox_input, :checkbox_input,
                                        :selected_options)&.first&.dig('value'))

      check_inputs(responds)
      responds
    end

    private

    def convert_place(value)
      case value
      when 'stationary'
        0
      when 'remote'
        1
      end
    end

    def convert_open_for_pp(value)
      value == 'open_for_PP' ? 1 : nil
    end

    def check_inputs(responds)
      inputs = responds.keys - %i[place open_for_pp]
      inputs.each do |input|
        responds[input] = ':clown_face:' if responds[input].nil?
      end
    end
  end
end

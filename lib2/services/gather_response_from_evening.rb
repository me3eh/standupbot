module Services
    class GatherRespondsFromEvening

        def initialize(params)
            @params=params 
        end
            
        def call
            responds={}
            inputs=[:first_input, :second_input, :third_input, :fourth_input, :prs]
            inputs.each.with_index do |input, index|
                responds[input] = @params.dig(:payload, :state, :values, input, input, :value)
            end
            check_inputs(responds)
            responds
        end

        private 

        def check_inputs(respond)
            inputs.each do |input|
                respond[input] = ":see_no_evil:" if respond[input].nil?
            end
            respond
        end
    end
end
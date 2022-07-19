
module Jsons
  module Checkbox
    extend self
    def call(options, initial_options = nil)
      raise ObjectMustBeArray.new unless options.is_a? Array
      raise ArrayMustBeFilledWithHashes.new unless options.all? Hash


      if initial_options.blank?
        {
          "type": "checkboxes",
          "options": options,
          "action_id": "checkbox_choice"
        }
      else
        {
          "type": "checkboxes",
          "options": options,
          "action_id": "checkbox_choice",
          "initial_options": prepare_initial_array(options, initial_options)
        }
      end
    end

    def prepare_initial_array(options, initial_options)

      return [options[0]] if initial_options == true

      array_with_choices = []
      initial_options.each do |initial|
        array_with_choices << options[initial]
      end
      array_with_choices
    end
  end
end

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
          "initial_options": [options[0]]
        }
      end
    end
  end
end
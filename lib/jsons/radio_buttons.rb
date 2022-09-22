
module Jsons
  module RadioButtons
    extend self

    def call(options, initial_option=nil)
      raise ObjectMustBeArray.new unless options.is_a? Array
      raise ArrayMustBeFilledWithHashes.new unless options.all? Hash
      if initial_option.blank?
        {
          "type": "radio_buttons",
          "options": options,
          "action_id": "radio_choice"
        }
      else
        {
          "type": "radio_buttons",
          "options": options,
          "action_id": "radio_choice",
          "initial_option": options[initial_option]
        }
      end
    end
  end
end
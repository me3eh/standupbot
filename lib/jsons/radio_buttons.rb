
module Jsons
  module RadioButtons
    extend self

    def call(options)
      raise ObjectMustBeArray.new unless options.is_a? Array
      raise ArrayMustBeFilledWithHashes.new unless options.all? Hash

      {
        "type": "radio_buttons",
        "options": options,
        "action_id": "radio_choice"
      }
    end
  end
end
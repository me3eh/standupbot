
module Jsons
  module Checkbox
    extend self
    def call(options)
      raise ObjectMustBeArray.new unless options.is_a? Array
      raise ArrayMustBeFilledWithHashes.new unless options.all? Hash

      {
        "type": "checkboxes",
        "options": options,
        "action_id": "checkbox_choice"
      }
    end
  end
end
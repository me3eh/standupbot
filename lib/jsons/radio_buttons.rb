
module Jsons
  module RadioButtons
    extend self

    def call(options)
      raise Errors.new("Parameter need to be array") unless options.is_a? Array
      raise Errors.new("Parameter need to have only hashes") unless options.all? Hash

      {
        "type": "radio_buttons",
        "options": options,
        "action_id": "choice"
      }
    end
  end
end
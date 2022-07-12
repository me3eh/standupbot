
module Jsons
  module Checkbox
    extend self
    def call(options)
      raise Errors.new("Parameter need to be array") unless options.is_a? Array
      raise Errors.new("Parameter need to have only hashes") unless options.all? Hash

      {
        "type": "checkboxes",
        "options": options,
        "action_id": "actionblank"
      }
    end
  end
end
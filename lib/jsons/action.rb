
module Jsons
  module Action
    extend self
    def call(elements)

      {
        "type": "actions",
        "elements": elements,
        "block_id": "action"
      }
    end
  end
end
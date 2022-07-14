module Jsons
  module Field
    extend self

    def call(title:, value:)
      {
        "title": title,
        "value": value,
        "short": false
      }
    end
  end
end

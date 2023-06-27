# frozen_string_literal: true

module Jsons
  module Image
    extend self

    def call(pic:, username:)
      {
        "type": "image",
        "image_url": pic,
        "title": {
          "type": "plain_text",
          "text": Services::RandomQuotes.call(username: username),
          "emoji": true
        },
        "alt_text": "This picture was once visible... it fills you with determination."
      }
    end
  end
end

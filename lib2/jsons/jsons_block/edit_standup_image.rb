# frozen_string_literal: true
module Jsons
  module EditStandupImage
    extend self

    def call(ts_message:)
      image_url = "https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8" +
        "MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=27&q=80"
      {
        "type": "image",
        "title": {
          "type": "plain_text",
          "text": "Mały koteł dla ciebie słodziaku",
          "emoji": true
        },
        "image_url": image_url,
        "alt_text": ts_message
      }
    end
  end
end

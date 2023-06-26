module Jsons
  module Header
    extend self

    def call(text:)
      {
        type: 'header',
        text: {
          type: 'plain_text',
          text: text,
          emoji: true
        }
      }
    end
  end
end

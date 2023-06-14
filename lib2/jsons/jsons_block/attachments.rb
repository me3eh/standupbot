
module Jsons
  module Attachments
    extend self
    def call(fields:, footer:nil, color:, pic:)
      if footer.nil?
        [
          fields: fields,
          footer: footer,
          color: color,
          thumb_url: pic
        ]
      else
      [
        fields: fields,
        footer: footer,
        color: color,
        thumb_url: pic
      ]
      end
    end
  end
end

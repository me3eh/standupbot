module Jsons
  module Attachments
    extend self
    def call(fields:, color:, pic:, footer: nil)
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

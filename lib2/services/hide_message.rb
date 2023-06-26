module Services
  module HideMessage
    extend self
    def call(link)
      Faraday.post(link, {
        delete_original: true
      }.to_json, 'Content-Type' => 'application/json')
    end
  end
end

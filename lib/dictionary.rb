require "uri"
require 'net/http'
require 'json'

module Dictionary
    def self.get_hint(word)
        uri = URI("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}")
        res = Net::HTTP.get(uri)

        res = res.body if res.is_a?(Net::HTTPSuccess)

        data = JSON.parse(res)

        return data[0]["meanings"][0]["definitions"][0]["definition"]
    end
end
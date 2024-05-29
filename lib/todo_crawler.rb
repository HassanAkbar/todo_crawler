# frozen_string_literal: true

require "uri"
require "net/http"
require "json"

class TodoCrawler
  BASE_URI = "https://jsonplaceholder.typicode.com/todos"

  def self.call(id)
    new(id).call
  end

  def initialize(id)
    @id = id
  end

  def call
    { success: true, todo: get_request("#{BASE_URI}/#{@id}") }
  rescue StandardError => e
    { success: false, error: e.message }
  end

  private

  def get_request(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)

    JSON.parse(response.body)
  end
end

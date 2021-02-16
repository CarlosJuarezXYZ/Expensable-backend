require "httparty"
require "json"

class TransactionController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def self.destroy(id, id_category, token)
    options = {
      headers: { "Authorization": "Token token=#{token}" }
    }

    response = delete("/categories/#{id_category}/transactions/#{id}", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end

  def self.update(id, data, id_category, token)
    options = {
      headers: { "Authorization": "Token token=#{token}",
                 "Content-Type": "application/json" },
      body: data.to_json
    }

    response = patch("/categories/#{id_category}/transactions/#{id}", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end

  def self.add(data, id_category, token)
    options = {
      headers: { "Authorization": "Token token=#{token}",
                 "Content-Type": "application/json" },
      body: data.to_json
    }
    response = post("/categories/#{id_category}/transactions", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end
end

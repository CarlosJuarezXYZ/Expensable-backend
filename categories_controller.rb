require "httparty"
require "json"

class CategoriesController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def self.index(token)
    options = {
      headers: { "Authorization": "Token token=#{token}" }
    }

    response = get("/categories", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.destroy(id, token)
    options = {
      headers: { "Authorization": "Token token=#{token}" }
    }

    response = delete("/categories/#{id}", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end

  def self.create(category_data, token)
    options = {
      headers: { "Authorization": "Token token=#{token}",
                 "Content-type": "application/json" },
      body: category_data.to_json
    }

    response = post("/categories", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end

  def self.update(id, category_data, token)
    options = {
      headers: { "Authorization": "Token token=#{token}",
                 "Content-type": "application/json" },
      body: category_data.to_json
    }

    response = patch("/categories/#{id}", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end
end

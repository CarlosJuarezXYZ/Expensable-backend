require_relative "categories_controller"
require_relative "transaction_controller"
require_relative "transaction"

module Categories
  def load_categories
    @categories = CategoriesController.index(@user_temp[:token])
  rescue Net::HTTPError => e
    puts e.message.red
  end

  def delete_category(id)
    CategoriesController.destroy(id, @user_temp[:token])
  rescue Net::HTTPError => e
    puts e.response.parsed_response.red
  end

  def create_category_default
    category_data = create_update_category_validation
    response = CategoriesController.create(category_data, @user_temp[:token])
    @id_default = response[:id].to_i
    p @id_default
    load_categories
  rescue Net::HTTPError => e
    puts e.message.red
  end

  def update_category(id)
    category_data_new = create_update_category_validation
    CategoriesController.update(id, category_data_new, @user_temp[:token])
  rescue Net::HTTPError => e
    puts e.message.red
  end
end

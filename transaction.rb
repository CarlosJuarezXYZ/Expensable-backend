require_relative "transaction_controller"

module Transaction
  def delete_transaction(id)
    index = @current_category[:transactions].find_index { |transaction| transaction[:id] == id }
    delete_transaction = TransactionController.destroy(id, @id_category, @user_temp[:token])
    if delete_transaction
      @current_category[:transactions][index] = delete_transaction
    else
      @current_category[:transactions].reject! { |transaction| transaction[:id] == id }
    end
  rescue Net::HTTPError => e
    puts e.response.parsed_response
  end

  def update_transaction(id)
    data = create_update_add_transation_validation
    index = @current_category[:transactions].find_index { |transaction| transaction[:id] == id }
    data[:notes] = @current_category[:transactions][index][:notes] if data[:notes] == ""
    TransactionController.update(id, data, @id_category, @user_temp[:token])
  rescue Net::HTTPError => e
    puts e.message.colorize(:red)
  end

  def add_transaction
    data = create_update_add_transation_validation
    TransactionController.add(data, @id_category, @user_temp[:token])
  rescue Net::HTTPError => e
    puts e.message.colorize(:red)
  end

  def add_to(id)
    data = create_update_add_transation_validation
    TransactionController.add(data, id, @user_temp[:token])
  rescue Net::HTTPError => e
    puts e.message.colorize(:red)
  end

  def add_to_default(id)
    data = { amount: 1, date: @current_day.to_s, notes: " " }
    TransactionController.add(data, id, @user_temp[:token])
  rescue Net::HTTPError => e
    puts e.message.colorize(:red)
  end
end

# Start here. Happy coding!
require_relative "menu_module"
require_relative "presenter"
require_relative "requester"
require_relative "session"
require_relative "categories"
require_relative "user"
require_relative "transaction"

class Expensable
  include Menu
  include Requester
  include Presenter
  include Session
  include Categories
  include User
  include Transaction

  def initialize
    @current_day = current_month
    @current_type = "expense"
  end

  def start
    print_welcome
    action, _id = main_menu_validation
    until action == "exit"
      case action
      when "login"
        login
        login_affter if @user_temp
      when "create_user" then create_user
      else puts "invalid option"
      end
      print_welcome
      action, _id = main_menu_validation
    end
    print_goodbye
  end

  def login_affter
    puts "Welcome to Expensable #{@user_temp[:first_name]}"
    secundary_menu
    action, id = secundary_menu_validation
    login_case(action, id)
  end

  def secundary_menu
    load_categories
    actual_data(@current_type)
    print_user_dashboard
  end

  def toggle
    @current_type = @current_type == "expense" ? "income" : "expense"
  end

  def actual_data(type_data)
    @current_categories = []
    @categories.each do |category|
      next if category[:transaction_type] != type_data

      temp = []
      category[:transactions].each do |trans|
        temp << trans if (Date.parse(trans[:date])).strftime("%B") == @current_day.strftime("%B")
      end
      next if temp == []

      @current_categories << { id: category[:id],
                               name: category[:name],
                               transaction_type: category[:transaction_type],
                               transactions: temp }
    end
    @current_categories
  end
end

expensable = Expensable.new
expensable.start

module Requester
  def main_menu_validation
    # this method show the first menu when you start the program and ask for action
    prompt = "login | create_user | exit"
    options = %w[login create_user exit]
    gets_options(prompt: prompt, options: options)
  end

  def create_user_validation
    # this method give a array whit 5 parameters
    email = gets_string("email : ")
    until email =~ /\w+@\w+\.\w{2,3}/
      puts "Invalid format"
      email = gets_string("email : ")
    end
    password = gets_string("password : ")
    until password.length > 5
      puts "Minimum 6 characters"
      password = gets_string("password : ")
    end
    first_name = gets_string("first_name : ", required: false)
    last_name = gets_string("last_name : ", required: false)
    phone = gets_string("phone : ", required: false)
    until phone == "" || phone =~ /\+*\d{2}*.?\d{9}/
      puts "Required format: +51 111222333 or 111222333"
      phone = gets_string("phone : ", required: false)
    end
    if phone == ""
      { email: email, password: password, first_name: first_name, last_name: last_name }
    else
      { email: email, password: password, first_name: first_name, last_name: last_name, phone: phone }
    end
  end

  def login_validation
    # ask user for username and password to connect with the API
    email = gets_string("email : ")
    password = gets_string("password : ")
    { email: email, password: password }
  end

  def secundary_menu_validation
    # ask  user for action information or delete or update information
    prompt = "create | show ID | update ID | delete ID\nadd-to ID | toggle | next | prev | logout"
    options = %w[create show update delete add-to toggle next prev logout]
    gets_options(prompt: prompt, options: options)
  end

  def last_menu_validation
    # ask for action and excute add, update, delete,next,prev,back
    prompt = "add | update ID | delete ID\nnext | prev | back"
    options = %w[add update delete next prev back]
    gets_options(prompt: prompt, options: options)
  end

  def create_update_category_validation
    # this method ask user for name and category
    name = gets_string("Name : ")
    transaction_type = gets_string("Transaction type : ").downcase
    until transaction_type.include?("income") || transaction_type.include?("expense")
      puts "Only income or expense"
      transaction_type = gets_string("Transaction type : ").downcase
    end
    { name: name, transaction_type: transaction_type }
  end

  def create_update_add_transation_validation
    # amount is a integer.to_s and date should be YYYY-MM-DD
    amount = gets_string("Amount : ")
    date = gets_string("Date : ")
    until amount.to_i.positive?
      puts "Cannot be zero"
      amount = gets_string("Amount : ")
    end
    until date =~ /^\d{4}-\d{2}-\d{2}$/
      puts "Required format: YYYY-MM-DD"
      date = gets_string("Date : ")
    end
    notes = gets_string("Notes : ", required: false)
    { amount: amount, date: date, notes: notes }
  end

  def gets_string(prompt, required: true)
    # print the prompt and evalute if the input is required, if is required this print "can't be blank"
    print prompt
    input = gets.chomp.strip

    unless !required && input.empty?
      while input.empty?
        puts "cannot be blank"
        print prompt
        input = gets.chomp.strip
      end
    end
    input
  end

  def gets_options(prompt:, options:, required: true)
    # Assume: this method recieve option and print the gets_options
    # and ask for the action to username
    # this return an array [action,id]
    puts prompt
    print ">> "
    input = gets.chomp.downcase.split.map(&:strip)
    if required && input[0] != ""
      until validate(input, options)
        puts "Invalid option"
        print ">> "
        input = gets.chomp.downcase.split.map(&:strip)
      end
    end
    input
  end

  def validate(input, options)
    options.include?(input[0]) && input.size < 3 && (input[1].nil? || !(input[1] =~ /^\d+$/).nil?)
  end
end

module Menu
  def login_case(action, id)
    until action == "logout"
      case action
      when "create" then create_category
      when "show" then show_category(id.to_i)
      when "update" then update_category(id.to_i)
      when "delete" then delete_category(id.to_i)
      else login_case_segundo(action, id)
      end
      secundary_menu
      action, id = secundary_menu_validation
    end
  end

  def create_category
    create_category_default
    add_to_default(@id_default.to_i)
  end

  def login_case_segundo(action, id)
    case action
    when "add-to" then add_to(id.to_i)
    when "toggle" then toggle
    when "next" then next_date
    when "prev" then prev_date
    else puts "invalid option"
    end
  end

  def show_category(id)
    @current_name_category = ""
    @id_category = id
    last_menu
    action, id = last_menu_validation
    show_case(action, id)
  end

  def last_menu
    load_categories
    actual_data(@current_type)
    select_id(@id_category)
    @current_name_category = @current_category[:name] if @current_name_category == ""
    print_categorie_table
  end

  def show_case(action, id)
    until action == "back"
      case action
      when "add" then add_transaction
      when "update" then update_transaction(id.to_i)
      when "delete" then delete_transaction(id.to_i)
      when "next" then next_date
      when "prev" then prev_date
      else puts "invalid option"
      end
      last_menu
      action, id = last_menu_validation
    end
  end
end

require_relative "user_controller"

module User
  def create_user
    user_data = create_user_validation

    @user_temp = UserController.create(user_data)
  rescue Net::HTTPError => e
    puts e.response.parsed_response["errors"][1]
    puts e.response.parsed_response["errors"][0]
  end
end

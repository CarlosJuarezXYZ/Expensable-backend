require_relative "session_controller"
module Session
  def login
    login_data = login_validation

    response = SessionController.login(login_data)
    @user_temp = response
  rescue Net::HTTPError => e
    puts e.message.red
  end

  def logout
    @user_temp = SessionController.logout(@user_temp[:token])
  rescue Net::HTTPError => e
    puts e.response.parsed_response
  end
end

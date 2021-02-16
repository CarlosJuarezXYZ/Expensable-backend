$LOAD_PATH.unshift("session_controller")

require "minitest/autorun"
require_relative "session_controller"

class LoginTest < Minitest::Test
  def test_when_input_valid_data_in_login
    assert_equal 6, SessionController.login({ "email": "kedein@mail.com", "password": "123456" }).length
  end

  def test_when_imput_data_incorrect_in_login
    error = assert_raises(Net::HTTPError) do
      SessionController.login({ "email": "kedein@mail.com", "password": "invalid" })
    end

    assert_equal "Unauthorized", error.message
  end
end

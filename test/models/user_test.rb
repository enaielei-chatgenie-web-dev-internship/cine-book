require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup()
    @user = User.new(
      email: "nommel.isanar.lavapie.amolat@gmail.com",
      full_name: "Nommel Isanar Lavapie Amolat",
      mobile_number: "09064527653",
      password: "123456",
      password_confirmation: "123456",
    )
  end

  test("should return error on invalid email") do
    @user.email = "@gmail.com"
    assert_not(@user.valid?())
  end

  test("should return error on invalid full_name") do
    @user.full_name = "a" * 101
    assert_not(@user.valid?())
  end

  test("should return error on invalid mobile_number") do
    @user.mobile_number = "99064527653"
    assert_not(@user.valid?())
  end

  test("should return error on invalid password") do
    @user.password = "1" * 5
    assert_not(@user.valid?())
  end
end

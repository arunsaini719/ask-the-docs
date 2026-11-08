require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")

    assert_equal "downcased@example.com", user.email_address
  end

  test "requires an email address" do
    user = User.new(password: "password1234")

    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "requires a valid email address" do
    user = User.new(email_address: "not-an-email", password: "password1234")

    assert_not user.valid?
    assert_includes user.errors[:email_address], "is invalid"
  end

  test "requires a unique normalized email address" do
    user = User.new(email_address: " ONE@EXAMPLE.COM ", password: "password1234")

    assert_not user.valid?
    assert_includes user.errors[:email_address], "has already been taken"
  end

  test "requires a password of at least twelve characters" do
    user = User.new(email_address: "new@example.com", password: "short")

    assert_not user.valid?
    assert_includes user.errors[:password], "is too short (minimum is 12 characters)"
  end
end

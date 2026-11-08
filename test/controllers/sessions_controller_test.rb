require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup { @user = User.take }

  test "new" do
    get new_session_path
    assert_response :success
  end

  test "create with valid credentials" do
    post session_path, params: { email_address: @user.email_address, password: "password1234" }

    assert_redirected_to root_path
    assert cookies[:session_id]

    session = @user.sessions.order(:created_at).last
    assert_in_delta 14.days.from_now, session.expires_at, 2.seconds
    set_cookie_headers = Array(response.headers["Set-Cookie"]).join("\n")
    assert_no_match(/session_id=.*(?:expires|max-age)/i, set_cookie_headers)
  end

  test "create with invalid credentials" do
    post session_path, params: { email_address: @user.email_address, password: "wrong" }

    assert_redirected_to new_session_path
    assert_nil cookies[:session_id]
  end

  test "sign in returns to root after an unauthenticated non-GET request" do
    delete session_path
    assert_redirected_to new_session_path

    post session_path, params: { email_address: @user.email_address, password: "password1234" }

    assert_redirected_to root_path
  end

  test "expired sessions require authentication" do
    sign_in_as(@user, expires_at: 1.minute.ago)

    get documents_path

    assert_redirected_to new_session_path
  end

  test "destroy" do
    sign_in_as(User.take)

    delete session_path

    assert_redirected_to new_session_path
    assert_empty cookies[:session_id]
  end
end

require "test_helper"

class SessionTest < ActiveSupport::TestCase
  test "expires after the session lifetime" do
    session = users(:one).sessions.create!

    assert_in_delta Session::LIFETIME.from_now, session.expires_at, 2.seconds
  end

  test "active excludes expired sessions" do
    expired_session = users(:one).sessions.create!(expires_at: 1.minute.ago)

    assert_not_includes Session.active, expired_session
  end
end

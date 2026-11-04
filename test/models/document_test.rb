require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  test "requires a title" do
    document = documents(:one)
    document.title = nil

    assert_not document.valid?
    assert_includes document.errors[:title], "can't be blank"
  end

  test "requires a body" do
    document = documents(:one)
    document.body = nil

    assert_not document.valid?
    assert_includes document.errors[:body], "can't be blank"
  end

  test "requires a user" do
    document = documents(:one)
    document.user = nil

    assert_not document.valid?
    assert_includes document.errors[:user], "must exist"
  end
end

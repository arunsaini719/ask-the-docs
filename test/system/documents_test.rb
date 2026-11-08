require "application_system_test_case"

class DocumentsTest < ApplicationSystemTestCase
  test "user signs in, creates a document, and signs out" do
    visit new_session_path

    fill_in "email_address", with: users(:one).email_address
    fill_in "password", with: "password1234"
    click_on "Sign in"

    assert_text "Documents"
    click_on "New document"

    fill_in "Title", with: "Support handbook"
    fill_in "Document content", with: "How we support our customers."
    click_on "Create document"

    assert_text "Document was successfully created."
    assert_text "Support handbook"
    assert_text "How we support our customers."

    click_on "Back to documents"
    click_on "Sign out"

    assert_current_path new_session_path
    assert_button "Sign in"
  end
end

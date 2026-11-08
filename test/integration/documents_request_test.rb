require "test_helper"

class DocumentsRequestTest < ActionDispatch::IntegrationTest
  test "signed-out users are redirected to sign in" do
    get documents_path

    assert_redirected_to new_session_path
  end

  test "signed-in users see only their own documents" do
    sign_in_as users(:one)

    get documents_path

    assert_response :success
    assert_select "a[href=?]", document_path(documents(:one)), minimum: 1
    assert_select "a[href=?]", document_path(documents(:two)), count: 0
  end

  test "signed-in users cannot view another user's document" do
    sign_in_as users(:one)

    get document_path(documents(:two))

    assert_response :not_found
  end

  test "signed-in users can create a document" do
    user = users(:one)
    sign_in_as user

    assert_difference -> { user.documents.count }, 1 do
      post documents_path, params: {
        document: {
          title: "Product handbook",
          body: "How we build and support the product.",
          user_id: users(:two).id
        }
      }
    end

    document = user.documents.find_by!(title: "Product handbook")

    assert_redirected_to document_path(document)
    assert_equal "How we build and support the product.", document.body
    assert_equal user, document.user
  end
end

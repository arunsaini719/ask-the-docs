require "test_helper"

class DocumentsRequestTest < ActionDispatch::IntegrationTest
  test "signed-out users are redirected to sign in" do
    get documents_path

    assert_redirected_to new_session_path
  end

  test "signed-in users can create a document" do
    user = users(:one)
    sign_in_as user

    assert_difference -> { user.documents.count }, 1 do
      post documents_path, params: {
        document: {
          title: "Product handbook",
          body: "How we build and support the product."
        }
      }
    end

    document = user.documents.order(:created_at).last

    assert_redirected_to document_path(document)
    assert_equal "Product handbook", document.title
  end
end

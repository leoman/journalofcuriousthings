require 'test_helper'

class PostTest < ActionDispatch::IntegrationTest
  test "admin index page loads" do
    get "/admin/posts"
    assert_select "h4", "Post#index"
  end
end

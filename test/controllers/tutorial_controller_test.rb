require "test_helper"

class TutorialControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get index" do
    get tutorial_url
    assert_response :success
  end
end

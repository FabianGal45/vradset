require "test_helper"

class AdvertisementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin) #grabs the admin from the users fixtures
    sign_in @user #This makes use of the Devise helper to sign in the user.
    @advertisement = advertisements(:one)
  end

  test "user is signed in" do
    sign_in @user
    get root_url
    assert_response :success
  end

  test "should get index" do
    get advertisements_url
    assert_response :success
  end

  test "should get new" do
    get new_advertisement_url
    assert_response :success
  end

  test "should create advertisement" do
    # The advertisement count should increase
    assert_difference("Advertisement.count") do
      post advertisements_url, params: { advertisement: {
          description: "test",
          title: "test",
          url: "test",
          file: fixture_file_upload("Advertisement_test.png", "image/png"),
          check_asai_all: '1',
          check_asai_children: '1'
        }}
    end

    # When an advertisement gets created it will redirect to it's show page. This is what is being checked here
    assert_redirected_to advertisement_url(Advertisement.last)
  end

  test "should show advertisement" do
    get advertisement_url(@advertisement)
    assert_response :success
  end

  test "should get edit" do
    get edit_advertisement_url(@advertisement)
    assert_response :success
  end

  test "should update advertisement" do
    patch advertisement_url(@advertisement), params: { advertisement: {
      description: @advertisement.description,
      title: @advertisement.title,
      url: @advertisement.url,
      file: fixture_file_upload("Advertisement_test.png", "image/png"),
      check_asai_all: '1',
      check_asai_children: '1'
    } }
    assert_redirected_to advertisement_url(@advertisement)
  end

  test "should destroy advertisement" do
    assert_difference("Advertisement.count", -1) do
      delete advertisement_url(@advertisement)
    end

    assert_redirected_to advertisements_url
  end
end

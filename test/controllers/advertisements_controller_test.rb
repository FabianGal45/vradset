require "test_helper"

class AdvertisementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Graps the users from the users fixtures
    @admin = users(:admin)
    @advertiser = users(:advertiser)
    @developer = users(:developer)

    # Signs in the admin to allow for general tests to pass. Where user needs specified sign_in method will be used.
    sign_in @admin #This makes use of the Devise helper to sign in the user.

    # Prepares the advertisemetns with the values from the fixtures
    @advertisement = advertisements(:one)
    @advertisementTwo = advertisements(:two)

    # As a file cannot be added within the fixtures due to the yml format, I am adding it here.
    @file = fixture_file_upload("Advertisement_test.png", "image/png")
    @advertisement.file.attach(@file)
    @advertisementTwo.file.attach(@file)
  end

  test "user is signed in" do
    sign_in @admin
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
          description: @advertisement.description,
          title: @advertisement.title,
          url: @advertisement.url,
          file: @file, # This requires the fixture_file_upload method to pass.
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

  test "Should get an image" do
    get get_image_url
    # Checking for the blob_url below will give a false positive where it will compare an image form a different advertisement.
    # rails_blob_url(@advertisement.file, disposition: "attachment", only_path: true)
    # Considering I care that there is an image, I had modified it to the assertion below:
    # https://api.rubyonrails.org/classes/ActionDispatch/Assertions/ResponseAssertions.html
    assert_redirected_to %r(\Ahttp://www.example.com/rails/active_storage/blobs/redirect/)
    assert_response :found
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
      file: @file,
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



  # This checks :authenticate_user!
  # When the user is not signed in they should not be able to access the following
  # with exception to index and get_image
  test "should deny access to show advertisements" do
    sign_out @admin
    get advertisement_url(@advertisement)
    assert_redirected_to new_user_session_path
  end

  test "should deny access to new advertisements" do
    sign_out @admin
    get new_advertisement_url
    assert_redirected_to new_user_session_path
  end

  test "should deny access to edit advertisements" do
    sign_out @admin
    get edit_advertisement_url(@advertisement)
    assert_redirected_to new_user_session_path
  end

  test "should deny access to create advertisements" do
    sign_out @admin
    post advertisements_url, params: { advertisement: {
      description: @advertisement.description,
      title: @advertisement.title,
      url: @advertisement.url,
      file: @file, # This requires the fixture_file_upload method to pass.
      check_asai_all: '1',
      check_asai_children: '1'
    }}
    assert_redirected_to new_user_session_path
  end

  test "should deny access to update advertisements" do
    sign_out @admin
    patch advertisement_url(@advertisement), params: { advertisement: {
      description: @advertisement.description,
      title: @advertisement.title,
      url: @advertisement.url,
      file: @file,
      check_asai_all: '1',
      check_asai_children: '1'
    } }
    assert_redirected_to new_user_session_path
  end

  test "should deny access to delete advertisements" do
    sign_out @admin
    delete advertisement_url(@advertisement)
    assert_redirected_to new_user_session_path
  end


  # This checks :verify_permission
  # When the user is a developer
  # they should not be able to access the following.
  test "should deny developer access to show advertisements" do
    sign_in @developer
    get advertisement_url(@advertisement)
    assert_redirected_to advertisements_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should deny developer access to new advertisements" do
    sign_in @developer
    get new_advertisement_url
    assert_redirected_to advertisements_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should deny developer access to edit advertisements" do
    sign_in @developer
    get edit_advertisement_url(@advertisement)
    assert_redirected_to advertisements_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should deny developer access to create advertisements" do
    sign_in @developer
    post advertisements_url, params: { advertisement: {
      description: @advertisement.description,
      title: @advertisement.title,
      url: @advertisement.url,
      file: @file, # This requires the fixture_file_upload method to pass.
      check_asai_all: '1',
      check_asai_children: '1'
    }}
    assert_redirected_to advertisements_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should deny developer access to update advertisements" do
    sign_in @developer
    patch advertisement_url(@advertisement), params: { advertisement: {
      description: @advertisement.description,
      title: @advertisement.title,
      url: @advertisement.url,
      file: @file,
      check_asai_all: '1',
      check_asai_children: '1'
    } }
    assert_redirected_to advertisements_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should deny developer access to delete advertisements" do
    sign_in @developer
    delete advertisement_url(@advertisement)
    assert_redirected_to advertisements_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

end

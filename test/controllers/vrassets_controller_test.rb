require "test_helper"

class VrassetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Graps the users from the users fixtures
    @admin = users(:admin)
    @advertiser = users(:advertiser)
    @developer = users(:developer)

    # Signs in the admin to allow for general tests to pass. Where user needs specified sign_in method will be used.
    sign_in @admin #This makes use of the Devise helper to sign in the user.

    # Variable vor VR asset object that uses the values from the fixtures.
    @vrasset = vrassets(:one)
  end

  test "user is signed in" do
    sign_in @admin
    get root_url
    assert_response :success
  end

  test "should get index" do
    get vrassets_url
    assert_response :success
  end

  test "should get new" do
    get new_vrasset_url
    assert_response :success
  end

  test "should create vrasset" do
    assert_difference("Vrasset.count") do
      post vrassets_url, params: { vrasset: {
        description: @vrasset.description,
        title: @vrasset.title,
        file: fixture_file_upload("BP_Poster_01.cuap", ".cuap"),
        image: fixture_file_upload("BP_Poster_01_Preview.png", "image/png")
      } }
    end

    assert_redirected_to vrasset_url(Vrasset.last)
  end

  test "should show vrasset" do
    get vrasset_url(@vrasset)
    assert_response :success
  end

  test "should get edit" do
    get edit_vrasset_url(@vrasset)
    assert_response :success
  end

  test "should update vrasset" do
    patch vrasset_url(@vrasset), params: { vrasset: {
      description: @vrasset.description,
      title: @vrasset.title,
      file: fixture_file_upload("BP_Poster_01.cuap", ".cuap"),
      image: fixture_file_upload("BP_Poster_01_Preview.png", "image/png")
    } }
    assert_redirected_to vrasset_url(@vrasset)
  end

  test "should destroy vrasset" do
    assert_difference("Vrasset.count", -1) do
      delete vrasset_url(@vrasset)
    end

    assert_redirected_to vrassets_url
  end



  # This checks :authenticate_user!
  # When the user is not signed in they should not be able to access the following
  # with exception to index and get_image
  test "should deny access to show VR assets" do
    sign_out @admin
    get vrasset_url(@vrasset)
    assert_redirected_to new_user_session_path
  end

  test "should deny access to new VR assets" do
    sign_out @admin
    get new_vrasset_url
    assert_redirected_to new_user_session_path
  end

  test "should deny access to edit VR assets" do
    sign_out @admin
    get edit_vrasset_url(@vrasset)
    assert_redirected_to new_user_session_path
  end

  test "should deny access to create VR assets" do
    sign_out @admin
    post vrassets_url, params: { vrasset: {
      description: @vrasset.description,
      title: @vrasset.title,
      file: fixture_file_upload("BP_Poster_01.cuap", ".cuap"),
      image: fixture_file_upload("BP_Poster_01_Preview.png", "image/png")
    } }
    assert_redirected_to new_user_session_path
  end

  test "should deny access to update VR assets" do
    sign_out @admin
    patch vrasset_url(@vrasset), params: { vrasset: {
      description: @vrasset.description,
      title: @vrasset.title,
      file: fixture_file_upload("BP_Poster_01.cuap", ".cuap"),
      image: fixture_file_upload("BP_Poster_01_Preview.png", "image/png")
    } }
    assert_redirected_to new_user_session_path
  end

  test "should deny access to delete VR assets" do
    sign_out @admin
    delete vrasset_url(@vrasset)
    assert_redirected_to new_user_session_path
  end



  # This checks :verify_permission
  # When the user is an advertiser and sometimes developer,
  # they should not be able to access the following.
  test "should deny advertiser & developer access to show VR assets" do
    sign_in @advertiser
    get vrasset_url(@vrasset)
    assert_response :found
    assert_equal "You are not authorized to perform this action.", flash[:alert]

    sign_in @developer
    get vrasset_url(@vrasset)
    assert_response :found
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should deny advertiser & developer access to new VR assets" do
    sign_in @advertiser
    get new_vrasset_url
    assert_redirected_to vrassets_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]

    sign_in @developer
    get new_vrasset_url
    assert_redirected_to vrassets_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should deny advertiser & developer access to edit VR assets" do
    sign_in @advertiser
    get edit_vrasset_url(@vrasset)
    assert_redirected_to vrassets_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]

    sign_in @developer
    get edit_vrasset_url(@vrasset)
    assert_redirected_to vrassets_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should deny advertiser & developer access to create VR assets" do
    sign_in @advertiser
    post vrassets_url, params: { vrasset: {
      description: @vrasset.description,
      title: @vrasset.title,
      file: fixture_file_upload("BP_Poster_01.cuap", ".cuap"),
      image: fixture_file_upload("BP_Poster_01_Preview.png", "image/png")
    } }
    assert_redirected_to vrassets_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]

    sign_in @developer
    post vrassets_url, params: { vrasset: {
      description: @vrasset.description,
      title: @vrasset.title,
      file: fixture_file_upload("BP_Poster_01.cuap", ".cuap"),
      image: fixture_file_upload("BP_Poster_01_Preview.png", "image/png")
    } }
    assert_redirected_to vrassets_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should deny advertiser & developer access to update VR assets" do
    sign_in @advertiser
    patch vrasset_url(@vrasset), params: { vrasset: {
      description: @vrasset.description,
      title: @vrasset.title,
      file: fixture_file_upload("BP_Poster_01.cuap", ".cuap"),
      image: fixture_file_upload("BP_Poster_01_Preview.png", "image/png")
    } }
    assert_redirected_to vrassets_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]

    sign_in @developer
    patch vrasset_url(@vrasset), params: { vrasset: {
      description: @vrasset.description,
      title: @vrasset.title,
      file: fixture_file_upload("BP_Poster_01.cuap", ".cuap"),
      image: fixture_file_upload("BP_Poster_01_Preview.png", "image/png")
    } }
    assert_redirected_to vrassets_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should deny advertiser & developer access to delete VR assets" do
    sign_in @advertiser
    delete vrasset_url(@vrasset)
    assert_redirected_to vrassets_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]

    sign_in @developer
    delete vrasset_url(@vrasset)
    assert_redirected_to vrassets_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

end

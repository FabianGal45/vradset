require "test_helper"

class VrassetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin) #grabs the admin from the users fixtures
    sign_in @user #This makes use of the Devise helper to sign in the user.
    @vrasset = vrassets(:one)
  end

  test "user is signed in" do # Check to see if the admin user is signed in. If it is then all tests should run fine.
    sign_in @user
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
end

require "application_system_test_case"

class VrassetsTest < ApplicationSystemTestCase
  setup do
    @user = users(:admin) #grabs the admin from the users fixtures
    sign_in @user #This makes use of the Devise helper to sign in the user.
    @vrasset = vrassets(:one)
  end

  test "visiting the index" do
    visit vrassets_url
    assert_selector "h1", text: "VR Assets"
  end

  test "should create vrasset" do
    visit vrassets_url
    click_on "New Asset"

    fill_in "Description", with: @vrasset.description
    fill_in "Title", with: @vrasset.title
    page.attach_file('vrasset_file', 'test\fixtures\files\BP_Poster_01.cuap')
    page.attach_file('vrasset_image', 'test\fixtures\files\BP_Poster_01_Preview.png')
    click_on "Submit"

    assert_text "Vrasset was successfully created"
    click_on "Back"
  end

  test "should update Vrasset" do
    visit vrasset_url(@vrasset)
    click_on "Edit", match: :prefer_exact

    fill_in "Description", with: @vrasset.description
    fill_in "Title", with: @vrasset.title
    page.attach_file('vrasset_file', 'test\fixtures\files\BP_Poster_01.cuap')
    page.attach_file('vrasset_image', 'test\fixtures\files\BP_Poster_01_Preview.png')
    click_on "Submit"

    assert_text "Vrasset was successfully updated"
    click_on "Back"
  end

  test "should destroy Vrasset" do
    visit vrasset_url(@vrasset)
    click_on "Delete", match: :first

    assert_text "Vrasset was successfully destroyed"
  end
end

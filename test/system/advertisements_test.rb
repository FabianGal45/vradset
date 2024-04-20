require "application_system_test_case"

class AdvertisementsTest < ApplicationSystemTestCase
  setup do
    @user = users(:admin) #grabs the admin from the users fixtures
    sign_in @user #This makes use of the Devise helper to sign in the user.
    @advertisement = advertisements(:one)
  end

  test "visiting the index" do
    visit advertisements_url
    assert_selector "h1", text: "Advertisements"
  end

  test "should create advertisement" do
    visit advertisements_url
    click_on "New advertisement"

    fill_in "Description", with: @advertisement.description
    fill_in "Title", with: @advertisement.title
    fill_in "Url", with: @advertisement.url
    click_on "Submit"

    assert_text "Advertisement was successfully created"
    click_on "Back"
  end

  test "should update Advertisement" do
    visit advertisement_url(@advertisement)
    click_on "Edit", match: :prefer_exact

    fill_in "Description", with: @advertisement.description
    fill_in "Title", with: @advertisement.title
    fill_in "Url", with: @advertisement.url
    click_on "Submit"

    assert_text "Advertisement was successfully updated"
    click_on "Back"
  end

  test "should destroy Advertisement" do
    visit advertisement_url(@advertisement)
    click_on "Delete", match: :first

    assert_text "Advertisement was successfully destroyed"
  end
end

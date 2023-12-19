require "application_system_test_case"

class VrassetsTest < ApplicationSystemTestCase
  setup do
    @vrasset = vrassets(:one)
  end

  test "visiting the index" do
    visit vrassets_url
    assert_selector "h1", text: "Vrassets"
  end

  test "should create vrasset" do
    visit vrassets_url
    click_on "New vrasset"

    fill_in "Description", with: @vrasset.description
    fill_in "Title", with: @vrasset.title
    click_on "Create Vrasset"

    assert_text "Vrasset was successfully created"
    click_on "Back"
  end

  test "should update Vrasset" do
    visit vrasset_url(@vrasset)
    click_on "Edit this vrasset", match: :first

    fill_in "Description", with: @vrasset.description
    fill_in "Title", with: @vrasset.title
    click_on "Update Vrasset"

    assert_text "Vrasset was successfully updated"
    click_on "Back"
  end

  test "should destroy Vrasset" do
    visit vrasset_url(@vrasset)
    click_on "Destroy this vrasset", match: :first

    assert_text "Vrasset was successfully destroyed"
  end
end

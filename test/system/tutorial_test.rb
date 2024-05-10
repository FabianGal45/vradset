require "application_system_test_case"
# Documentation: https://rubydoc.info/github/jnicklas/capybara/Capybara/Node/Actions
class TutorialTest < ApplicationSystemTestCase

  test "visiting the index" do
    visit tutorial_url
    assert_selector "h1", text: "Tutorial"
  end

  test "introduction to VR-Adset is showing then collapse" do
    visit tutorial_url
    click_on "Introduction to VR-Adset"
    assert_selector "strong", text: 'VR-Adset', visible: true

    # Collapse
    click_on "Introduction to VR-Adset"
    assert_selector "strong", text: 'VR-Adset', visible: false
  end

  test "Tutorial for Advertisers is showing then collapse" do
    visit tutorial_url
    click_on "Tutorial for Advertisers"
    assert_selector "p", text: 'You are in luck!', visible: true

    # Collapse
    click_on "Tutorial for Advertisers"
    assert_selector "p", text: 'You are in luck!', visible: false
  end

  test "Tutorial for Developers is showing then collapse" do
    visit tutorial_url
    click_on "Tutorial for Developers"
    assert_selector "h2", text: 'Required Software:', visible: true

    # Collapse
    click_on "Tutorial for Developers"
    assert_selector "h2", text: 'Required Software:', visible: false
  end

end

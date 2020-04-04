require "application_system_test_case"

class Admin::ThemesTest < ApplicationSystemTestCase
  setup do
    @admin_theme = admin_themes(:one)
  end

  test "visiting the index" do
    visit admin_themes_url
    assert_selector "h1", text: "Admin/Themes"
  end

  test "creating a Theme" do
    visit admin_themes_url
    click_on "New Admin/Theme"

    click_on "Create Theme"

    assert_text "Theme was successfully created"
    click_on "Back"
  end

  test "updating a Theme" do
    visit admin_themes_url
    click_on "Edit", match: :first

    click_on "Update Theme"

    assert_text "Theme was successfully updated"
    click_on "Back"
  end

  test "destroying a Theme" do
    visit admin_themes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Theme was successfully destroyed"
  end
end

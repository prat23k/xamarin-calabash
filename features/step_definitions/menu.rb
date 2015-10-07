When(/^the menu is displayed/) do
  @home_page.assert_nowtv_logo
end

Then(/^the displayed menu items must match those from the feed$/) do
  @home_page.compare_menu_content_with_feed
end

Given(/^the user has opened the menu$/) do
  @home_page.open_menu
end
Given(/^the user is viewing the (.*) page$/) do |page|
  @destination_page = page
  @menu_item_page = @home_page.go_to_menu_page page
end

When(/^the content has loaded$/) do
  @menu_item_page.wait_for_packshot_to_load
end

Then(/^the displayed movie titles must match those from the feed$/) do
  @menu_item_page.compare_page_with_feed @destination_page
end

When(/^the user selects the "([^"]*)" sub\-menu$/) do |submenu|
  @destination_page = submenu
  @menu_item_page.go_to_submenu submenu
end
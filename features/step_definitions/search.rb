Given(/^the user is on the Search page$/) do
  @search_page = @home_page.go_to_search
end

When(/^the a search term "([^"]*)" has been entered$/) do |search_term|
  @search_request = search_term
  @search_page.search_enter_search search_term
end

Then(/^the search results from the api should be displayed$/) do
  @search_page.search_verify_results @search_request
end


Given(/^I have performed a search$/) do
 @search_page = @home_page.go_to_search
 @search_page.search_enter_search "red"
 @search_page.search_get_visibile_results.length.should > 0
end

When(/^I press the on\-screen Back button$/) do
  @home_page= @search_page.action_bar_navigate_up
end

Then(/^I should be returned to the Home page$/) do
  @home_page.action_bar_check_home
end
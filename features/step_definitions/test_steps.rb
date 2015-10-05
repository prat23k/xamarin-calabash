Given(/^I am on the first screen$/) do
  sleep(5)
  puts "testing app launch"
  @current_page = page(HomePage).await(timeout: 30)
  @current_page.print_something
end
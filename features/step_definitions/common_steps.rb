
Given(/^the app is launched$/) do
  sleep(5)
  @home_page = page(HomePage).await
end
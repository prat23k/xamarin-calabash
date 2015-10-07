Feature: As an Atlas Mobile App User I want to be presented with the content from the feed

  @android
  Scenario: User initiates a Search
    Given the user is on the Search page
    When the a search term "red" has been entered
    Then the search results from the api should be displayed

  @android
  Scenario: User returns from a Search
    Given I have performed a search
    When I press the on-screen Back button
    Then I should be returned to the Home page
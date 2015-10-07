Feature: As an Atlas Mobile App User I want to be presented with the content from the feed

  @android
  Scenario Outline: User views the Home Page
    Given the user is viewing the <page> page
    When the content has loaded
    Then the displayed movie titles must match those from the feed

  Examples:
    | page     |
    | Home     |
    | Catch Up |
Feature: As an Atlas Mobile App User I want to be presented with the content from the feed

  @android
  Scenario: User views the menu
    Given the user has opened the menu
    When the menu is displayed
    Then the displayed menu items must match those from the feed
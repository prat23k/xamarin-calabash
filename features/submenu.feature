Feature: As an Atlas Mobile App User I want to be presented with the sub-menu content from the feed

  @android
  Scenario: User selects a sub-menu
    Given the user is viewing the Catch Up page
    When the user selects the "COMEDY CENTRAL" sub-menu
    Then the displayed movie titles must match those from the feed
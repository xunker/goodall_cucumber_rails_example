Feature: /widgets

  Scenario: I get a list of widgets
    Given widget "foo" exists
    And I get "/widgets.json"
    Then the response should include 1 widget
    And the response should include widget "foo"

  Scenario: I get a list of widgets and there are none
    Given no widgets exist
    And I get "/widgets"
    Then the response should include 0 widgets
    
  Scenario: I get a widget
    Given widget "foo" exists
    And I get "/widget/foo"
    Then the response should be widget "foo"

  Scenario: I get a widget that does not exist
    Given I get "/widget/nonexistent"
    Then I should get a "record_not_found" error

  Scenario: I create a new widget
    Given I post "/widget" with:
      | name | foo |
    Then the response should be a success
    And widget "foo" should exist

  Scenario: I create a widget without providing a name
    Given I post "/widget" with:
      | name | |
    Then I should get a "validation_failed" error

  Scenario: I create a widget using a name with disallowed characters
    Given I post "/widget" with:
      | name | blah blah blah|
    Then I should get a "validation_failed" error

  Scenario: I create a widget using a name that is already taken
    Given widget "foo" exists
    Given I post "/widget" with:
      | name | blah blah blah|
    Then I should get a "validation_failed" error

  Scenario: I delete a widget
    Given widget "foo" exists
    Given I delete "/widget/foo"
    Then widget "foo" should not exist

  Scenario: I delete a widget that does not exist
    Given I delete "/widget/nonexistent"
    Then I should get a "record_not_found" error


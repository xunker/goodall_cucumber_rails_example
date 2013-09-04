Feature: /widgets.json

  Scenario: I get a list of widgets
    Given widget "foo" exists
    And I get "/widgets.json"
    Then the response should include 1 widget
    And the response should include widget "foo"

  Scenario: I get a list of widgets and there are none
    Given no widgets exist
    And I get "/widgets.json"
    Then the response should include 0 widgets
    
  Scenario: I get a widget
    Given widget "foo" exists
    And I get "/widgets/foo.json"
    Then the response should be widget "foo"

  Scenario: I get a widget that does not exist
    Given I get "/widgets/nonexistent.json"
    Then I should get a "ActiveRecord::RecordNotFound" error

  Scenario: I create a new widget
    Given I post "/widgets.json" with:
      | name | foo |
    Then the response should be widget "foo"

  Scenario: I create a widget using a name that is already taken
    Given widget "foo" exists
    Given I post "/widgets.json" with:
      | name | foo |
    Then I should get a "validation_failed" error

  Scenario: I delete a widget
    Given widget "foo" exists
    Given I delete "/widgets/foo.json"
    Then I should get a successful response

  Scenario: I delete a widget that does not exist
    Given I delete "/widgets/nonexistent.json"
    Then I should get a "ActiveRecord::RecordNotFound" error


Feature: Manage issues
  In order to manage issues
  I want to be able to create, edit, destroy issues
  
  Background:
    Given I have no issues
    And I have no users
    And the following users exist
      | user | name | email           | admin |
      | Ann  | Ann  | ann@ann.com     | false |
      | Fred | Fred | fred@gmail.com  | true  |
    And the following issues exist
      | name    | description | user        |
      | title 1 | lorem       | user "Fred" | 
      | title 2 | lorem       | user "Ann"  |
      | title 3 | lorem       | user "Ann" |

  Scenario: Create new issue
    Given I have no users
    And I have user with email "ala@ala.com"
    And I am signed in as "ala@ala.com" with password "foobar"
    And I am on the new issue page
    When I fill in "Name" with "title 1"
    And I fill in "Description" with "content 1"
    And I press "Create"
    Then I should see "Issue was successfully created."
    And I should see "title 1"
    And I should see "ala@ala.com"

  Scenario: Delete issues
    Given I am signed in as "ann@ann.com" with password "foobar"
    And I delete the issue named "title 1"
    And I delete the issue named "title 2"
    Then I should have 2 issues
    Given I am on the signout page
    And I am signed in as "fred@gmail.com" with password "foobar"
    When I delete the issue named "title 1"
    And I delete the issue named "title 3"
    Then I should have 0 issue

  Scenario: Edit issues
    Given I am signed in as "ann@ann.com" with password "foobar"
    When I edit the issue named "title 1"
    Then I should see "not authorized"
    When I edit the issue named "title 2"
    And I fill in "Name" with "new title 2"
    And I press "Update Issue"
    Then I should see "Issue was successfully updated." 

    Given I am on the signout page
    When I am signed in as "fred@gmail.com" with password "foobar"
    And I edit the issue named "new title 2"
    And I fill in "Name" with "edited by admin"
    And I press "Update Issue"
    Then I should see "Issue was successfully updated."

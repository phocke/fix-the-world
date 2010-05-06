Feature: Manage wishes
  In order to manage wishes
  I want to be able to create, edit, destroy wishes
  
  Background:
    Given I have no wishes
    And I have no users
    And the following users exists
      | user | name | email           | admin |
      | Ann  | Ann  | ann@ann.com     | false |
      | Fred | Fred | fred@gmail.com  | true  |
    And the following wishes exist
      | name    | content | user        |
      | title 1 | lorem   | user "Fred" | 
      | title 2 | lorem   | user "Ann"  |
      | title 3 | lorem   | user "Fred" |

  Scenario: Register new wish
    Given I have no users
    And I have user with email "ala@ala.com"
    And I am signed in as "ala@ala.com" with password "foobar"
    And I am on the new wish page
    When I fill in "Name" with "title 1"
    And I fill in "Content" with "content 1"
    And I press "Create"
    Then I should see "Wish was successfully created."
    And I should see "title 1"
    And I should see "ala@ala.com"

  Scenario: Delete wishes
    Given I am signed in as "ann@ann.com" with password "foobar"
    When I delete the wish named "title 1"
    And I delete the wish named "title 2"
    Then I should have 3 wishes
    Given I am on the signout page
    And I am signed in as "fred@gmail.com" with password "foobar"
    When I delete the wish named "title 1"
    And I delete the wish named "title 2"
    Then I should have 1 wish

  Scenario: Edit wishes
    Given I am signed in as "ann@ann.com" with password "foobar"
    When I edit the wish named "title 1"
    Then I should see "not authorized"
    When I edit the wish named "title 2"
    And I fill in "Name" with "new title 2"
    And I press "Update Wish"
    Then I should see "Wish was successfully updated." 

    Given I am on the signout page # as an admin (not author)
    When I am signed in as "fred@gmail.com" with password "foobar"
    And I edit the wish named "new title 2"
    And I fill in "Name" with "edited by admin"
    And I press "Update Wish"
    Then I should see "Wish was successfully updated."

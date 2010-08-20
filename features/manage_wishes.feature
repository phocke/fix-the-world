Feature: Manage wishes
  In order to manage wishes
  I want to be able to create, edit, destroy wishes
  
  Background:
    Given I have no wishes
    And I have no issues
    And I have no users
    And the following users exist
      | user | name | email           | admin |
      | Ann  | Ann  | ann@ann.com     | false |
      | Fred | Fred | fred@gmail.com  | true  |
    And  the following issues exist
      | issue | name  | user        |
      | world | world | user "Ann"  |
    And the following wishes exist
      | name    | content | user        | issue         |
      | title 1 | lorem   | user "Fred" | issue "world" |
      | title 2 | lorem   | user "Ann"  | issue "world" |
      | title 3 | lorem   | user "Fred" | issue "world" |

  Scenario: Create new wish
    Given I have no wishes
    And I am signed in as "ann@ann.com" with password "foobar"
    When I create new wish for issue named "world"
    When I fill in "Name" with "title 1"
    And I fill in "Content" with "content 1"
    And I fill in "Tag list" with "a, b, c, a, b, z"
    When I press "Create Wish"
    Then I should have 1 wish
    Then I should see "Wish was successfully created."
    And I should see "title 1"
    And I should see "ann@ann.com"
    And I should see "a, b, c, z"


  Scenario: Delete wishes
    Given I am signed in as "ann@ann.com" with password "foobar"
    When I delete the wish named "title 2"
    Then I should have 2 wishes
    Given I am on the destroy user session page
    And I am signed in as "fred@gmail.com" with password "foobar"
    When I delete the wish named "title 1"
    And I delete the wish named "title 3"
    Then I should have 0 wish

  Scenario: Edit wishes
    Given I am signed in as "ann@ann.com" with password "foobar"
    When I edit the wish named "title 2"
    And I fill in "Name" with "new title 2"
    And I press "Update Wish"
    Then I should see "Wish was successfully updated." 

    Given I am on the destroy user session page
    When I am signed in as "fred@gmail.com" with password "foobar"
    And I edit the wish named "new title 2"
    And I fill in "Name" with "edited by admin"
    And I press "Update Wish"
    Then I should see "Wish was successfully updated."

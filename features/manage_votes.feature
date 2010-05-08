Feature: Manage votes
  In order to vote
  I want to be able to add vote

  Scenario: Add vote
    Given I have no users, wishes, votes
    And the following users exist:
      | email           |
      | bob@bob.com     |
      | admin@gmail.com |
    And the following wishes exist:
      | name   |
      | wish 1 |
    Given I am signed in as "bob@bob.com" with password "foobar"
    When I see the wish named "wish 1" 
    And I follow "+"
    Then I should see "Successfully added vote"
    Then wish named "wish 1" should have 1 vote
    When I add vote for wish named "wish 1"
    Then I should see "Don't cheat!"
    Then wish named "wish 1" should have 1 vote

    Given I am on the signout page
    Given I am signed in as "admin@gmail.com" with password "foobar"
    When I see the wish named "wish 1" 
    And I follow "+"
    Then I should see "Successfully added vote"
    Then wish named "wish 1" should have 2 votes

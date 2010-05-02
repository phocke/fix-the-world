Feature: Manage Users
  In order to manage user details
  As a security enthusiast
  I want to edit user profiles only when authorized
  
  Scenario Outline: Log in
    Given I have no users
    And the following user records
      | email             | password |
      | bob@bob.com       | secret   |
      | admin@gmail.com   | secret   |
    Given I am logged in as "<email>" with password "secret"
    When I go to session
    Then I should <action>

    Examples:
      | email           | action              |
      | bob@bob.com     | see "Logged in"     |
      | bbob@bob.com    | see "Logged out" |
      | admin@gmail.com | see "Logged in"     |

Feature: Manage Users
  In order to manage user details
  As a security enthusiast
  I want to be able to sign up, sing in and sing out

  Scenario Outline: Sign up
    Given I have no users
    When I sign up as "<email>" with name "<name>" and password "secret"
    Then I should <action> "Signed up succesfully"

    Examples:
      | email             | name    | action  |
      | frank@gmail.com   | Frank   | see     | 
      | bob.nice.com      | bob     | not see |
      | guy@example.com   |         | not see |

  Scenario Outline: Sign in
    Given I have no users
    And the following user records
      | email             | password |
      | bob@bob.com       | secret   |
      | admin@gmail.com   | secret   |
    Given I am signed in as "<email>" with password "secret"
    When I go to the session page
    Then I should <action>

    Examples:
      | email           | action              |
      | bob@bob.com     | see "Signed in"     |
      | bbob@bob.com    | see "Signed out"    |
      | admin@gmail.com | see "Signed in"     |

  Scenario: Sign out
    Given I have no users
    And I have user "ala@ma.kota"
    And I am signed in as "ala@ma.kota" with password "foobar"
    When I sign out
    And I go to the session page
    Then I should see "Signed out"

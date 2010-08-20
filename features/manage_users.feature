Feature: Manage users
  In order to manage user details
  As a security enthusiast
  I want to be able to sign up, sing in and sing out

  Scenario Outline: Sign up
    When I sign up as "<email>" with name "<name>" and password "secret"
    Then I should <action> "You have signed up successfully."

    Examples:
      | email             | name    | action  |
      | frank@gmail.com   | Frank   | see     | 
      | bob.bob.com       | Bob     | not see |
      | ann@ann.com       |         | not see |

  Scenario Outline: Sign in
    Given the following users exists:
      | email             | password |
      | bob@bob.com       | secret   |
      | admin@gmail.com   | secret   |
    Given I am signed in as "<email>" with password "secret"
    Then I should <action>

    Examples:
      | email           | action                            |
      | bob@bob.com     | see "Signed in successfully."     |
      | bbob@bob.com    | not see "Signed in successfully." |
      | admin@gmail.com | see "Signed in successfully."     |

  Scenario: Sign out
    Given I have user with email "ala@ma.kota"
    And I am signed in as "ala@ma.kota" with password "foobar"
    When I go to the destroy user session page
    Then I should see "Signed out successfully."

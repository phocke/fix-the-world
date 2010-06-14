Feature: Manage tags
  In order to see tagged wishes
  
  Background:
    Given I have no wishes
    And I have no issues
    And I have no users
    And  the following issues exist
      | issue  | name   |
      | krakow | krakow |
      | warsaw | warsaw |

    And the following wishes exist
      | name    | content | tag_list    | issue          |
      | title 1 | lorem   | a, b, c, z  | issue "krakow" |
      | title 2 | lorem   | b, x, y, z  | issue "krakow" |
      | title 3 | lorem   | w, a, d, y  | issue "warsaw" |

  Scenario: See all tagged wishes
    Given I see all wishes tagged with "a"
    Then I should see "title 1"
    And I should see "title 3"
    And I should not see "title 2"

    Given I see all wishes tagged with "z"
    Then I should see "title 1"
    And I should see "title 2"
    And I should not see "title 3"

  Scenario: See tagged wishes of the issue
    Given I see wishes of issue "krakow" tagged with "a"
    Then I should see "title 1"
    And I should not see "title 2"
    And I should not see "title 3"

    Given I see wishes of issue "krakow" tagged with "b"
    Then I should see "title 1"
    And I should see "title 2"
    And I should not see "title 3"

    Given I see wishes of issue "warsaw" tagged with "b"
    Then I should not see "title 1"
    And I should not see "title 2"
    And I should not see "title 3"

    Given I see wishes of issue "warsaw" tagged with "y"
    Then I should not see "title 1"
    And I should not see "title 2"
    And I should see "title 3"

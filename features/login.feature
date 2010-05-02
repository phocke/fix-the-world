Feature: Login 
  In order to login
  As a anonymous user
  I want to login

  Scenario: Login
    Given The following user records
      |email                   |name      |admin |password |
      |phocke@gmail.com        |przmek    |true  |pajakk   |
      |hoooock@gmail.com       |przmekk   |false |butelka  |
      |sebcioz@gmail.com       |sebastian |true  |do_zucia |
      |super-sebcioz@gmail.com |seba      |false |guuuma   |
    Given I am logged in with email "sebcioz@gmail.com" and password "do_zucia"
    When I go to session 
    Then I should see "Logged in as sebastian"

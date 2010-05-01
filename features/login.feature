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
    Given I am logged in with email "<email>" and password "<password>"
    #When I visit new_session 
    #And I fill password with "pajakk"
    #And I fill email with "phocke@gmail.com"
    
    Then I should see "logged in as a" "<name>"

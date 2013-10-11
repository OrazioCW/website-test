Feature: Sign out from Blinkbox books
  As a signed in user
  I want to sign out from Blinkbox books
  So that I can prevent unauthorised access to my account

  Background:
    Given I am on the home page
    And I have signed in

  @smoke
  Scenario: Sign out from home page
    When I select Sign out link from drop down menu
    Then I should be signed out successfully
    And I am redirected to Home page

  Scenario Outline: Sign out from Manage My Account pages
    Given I am on the <tab_name> tab
    When I click Sign out button
    Then I should be signed out successfully
    And I am redirected to Home page

  @smoke
  Examples: smoke
    | tab_name              |
    | Your personal details |

  @CWA-184
  Examples: Other sign out scenarios
    | tab_name                |
    | Your payments           |
    | Order & payment history |
    | Your devices            |

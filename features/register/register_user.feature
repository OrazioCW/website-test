Feature: Register a new Blinkbox books user
  As a guest user of Blinkbox books
  I want to sign up
  So that I can buy and read books

  Background:
   Given I am a guest user

 @smoke
 Scenario: Navigate to register page
   Given I am on the Sign in page
   When I click register button
   Then Register page is displayed

 @smoke
 Scenario: Happy path-register user
   Given I am on Register page
   When I enter valid personal details
   And I choose a valid password
   And I accept terms and conditions
   And I submit registration details
   Then Registration success page is displayed



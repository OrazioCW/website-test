@navigation @ie @safari
Feature: Global Header
  As a user
  I want to be able to navigate around the website using the header
  So that I can find the page I'm looking for

  Background:
    Given I am on the home page

  @sanity @production
  Scenario: Clicking on the website logo
    When I click on the Bestsellers header tab
    And I click on the website logo
    Then Home page is displayed

  @sanity @production
  Scenario Outline:
    When I click on the <tab_name> header tab
    Then <tab_name> page is displayed

  Examples:
    | tab_name     |
    | Authors      |
    | Free eBooks  |
    | New releases |
    | Bestsellers  |
    | Categories   |

  @production
  Scenario Outline: Navigating through site by clicking Shop links from the hamburger Menu
    When I select <shop_link> link from the hamburger Menu
    Then <shop_link> page is displayed

  Examples:
    | shop_link    |
    | Categories   |
    | Bestsellers  |
    | Free eBooks  |
    | Authors      |
    | New releases |

  @CWA-1029 @unstable @production
  Scenario Outline: Clicking Support links from the hamburger Menu
    When I select <support_link> link from the hamburger Menu
    Then I am redirected to the "<support_page>" support page in a new window

  Examples:
    | support_link | support_page  |
    | FAQs         | View all FAQs |
    | Contact us   | Contact us    |

  @sanity @production
  Scenario: Navigate to home page from the hamburger Menu
    Given I am on Categories page
    When I select Featured link from the hamburger Menu
    Then Home page is displayed
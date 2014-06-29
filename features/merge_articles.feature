Feature: Merge Articles
  As a blog administrator
  In order to keep conversations clear
  I want to be able to merge blog posts

  Background:
    Given the blog is set up

  Scenario: A non-admin user should not be able to merge articles
    Given I am logged in as a regular user
    And I am on the All Articles page
    And I follow "Edit" within ".action"
    Then I should not see "Merge Articles"

  Scenario: As an admin user I should be able see the article merge control
    Given I am logged into the admin panel
    And I am on the All Articles page
    And I follow "Edit" within ".action"
    Then I should see "Merge Articles"


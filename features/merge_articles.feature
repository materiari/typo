Feature: Merge Articles
  As a blog administrator
  In order to keep conversations clear
  I want to be able to merge blog posts

  Background:
    Given the blog is set up
    Given the following articles exist:
  | id | title    | body               | 
  | 2  | article1 | This is article 1. |
  | 3  | article2 | This is article 2. |
  | 4  | article3 | This is article 3. |

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

  Scenario: When articles are merged, the merged article should contain the text of both previous articles.
    Given I am logged into the admin panel
    And I am on the All Articles page
    And I follow "article3"
    Then I should see "Merge Articles"
    And I fill in "merge_with" with "2"
    And I press "Merge"
  

Feature: Merge Articles
  As a blog administrator
  In order to keep conversations clear
  I want to be able to merge blog posts

  Background:
    Given the blog is set up
    And the following articles exist:
  | id | title             | body               |author |published |user_id|
  | 3  | My first article  | This is article 1. |Jim    |true      |      1|
  | 4  | My second article | This is article 2. |Robert |true      |      1|
  | 5  | My third          | This is article 3. |Alfredo|true      |      1|
    And the following comments exist:
  |author |body                                 |article_id|
  |Jeremy |Commenting on article 2              |         4|
  |Jeremy |Another comment on second article    |         4|
  |Andy   |A comment on the first article       |         3|
  |Mary   |Nobody cares about the third article |         5|
    
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

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged into the admin panel
    And I follow "All Articles"
    Then I follow "My second article"
    Then I should see "Merge Articles"
    And I fill in "merge_with" with "3"
    And I press "Merge"
    Then I should see "This is article 2"
    And I should see "This is article 1"

  Scenario: When articles are merged, the comments should be merged as well
    Given I am logged into the admin panel
    And I follow "All Articles"
    Then I follow "My second article"
    Then I should see "Merge Articles"
    And I fill in "merge_with" with "3"
    And I press "Merge"
    And I navigate to "/previews/6"
    Then I should see "3 comments"
    And I should see "Jeremy"
    And I should see "Andy"



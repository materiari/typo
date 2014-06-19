Feature: Add a category
  As a blog administrator
  In order to group blog posts easily
  I want to be able to create categories of posts

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Successfully add a category
    When I follow "Categories"
    And I fill in "category_name" with "Cool Stuff Category"
    And I fill in "category_keywords" with "cool"
    And I fill in "category_description" with "Blog entries about things that are cool"
    And I press "Save"
    Then I should see "Category was successfully saved."

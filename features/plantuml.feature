Feature: Plantuml Rendering

  As a liquid user, I want to use plantuml diagram

  Background:
    Given I have a liquid template with:
      """
      {% plantuml %}
      Bob->Alice : hello
      {% endplantuml %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'
    And the output should not contains '<\?xml'

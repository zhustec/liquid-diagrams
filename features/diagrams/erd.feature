@diagrams
@slow
Feature: Erd

  As a liquid user, I want to use erd diagram

  Background:
    Given I have a liquid template with:
      """
      {% erd %}
        [Person]
        name
        height
      {% enderd %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'

@diagrams
Feature: Nomnoml

  As a liquid user, I want to use nomnoml diagram

  Background:
    Given I have a liquid template with:
      """
      {% nomnoml %}
      [Pirate|eyeCount: Int|raid();pillage()|
        [beard]--[parrot]
        [beard]-:>[foul mouth]
      ]
      {% endnomnoml %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'

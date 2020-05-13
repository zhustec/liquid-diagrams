@diagrams
@slow
Feature: Svgbob

  As a liquid user, I want to use svgbob diagram

  Background:
    Given I have a liquid template with:
      """
      {% svgbob %}
        +------+
        |      |
        +------+
      {% endsvgbob %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'

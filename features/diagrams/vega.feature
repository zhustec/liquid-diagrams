@diagrams
Feature: Vega

  As a liquid user, I want to use vega diagram

  Background:
    Given I have a liquid template with:
      """
      {% vega %}
      {
        "data": {
          "values": [
            {"a": "A", "b": 28}
          ]
        },
        "mark": "bar"
      }
      {% endvega %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'

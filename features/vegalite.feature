Feature: Vegalite Rendering

  As a liquid user, I want to use vegalite diagram

  Background:
    Given I have a liquid template with:
      """
      {% vegalite %}
      {
        "data": {
          "values": [
            {"a": "A", "b": 28}
          ]
        },
        "mark": "bar"
      }
      {% endvegalite %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'

@diagrams
Feature: Netlistsvg

  As a liquid user, I want to use netlistsvg diagram

  Background:
    Given I have a liquid template with:
      """
      {% netlistsvg %}
      {
        modules: {
          up3down5: {
            cells: {
              "$add$input.v:17$3": {
                type: "$add",
                connections: {}
              }
            }
          }
        }
      }
      {% endnetlistsvg %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'

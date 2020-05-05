Feature: Blockdiag Rendering

  As a liquid user, I want to use blockdiag diagram

  Background:
    Given I have a liquid template with:
      """
      {% blockdiag %}
      blockdiag {
        A -> B -> C -> D;
        A -> E -> F -> G;
      }
      {% endblockdiag %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'

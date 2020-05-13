@diagrams
Feature: Graphviz

  As a liquid user, I want to use graphviz diagram

  Background:
    Given I have a liquid template with:
      """
      {% graphviz %}
      digraph {
        A -> B;
      }
      {% endgraphviz %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'
    And the output should not contains '<\?xml'

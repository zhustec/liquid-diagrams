Feature: Mermaid Rendering

  As a liquid user, I want to use mermaid diagram

  Background:
    Given I have a liquid template with:
      """
      {% mermaid %}
      sequenceDiagram
          participant John
          participant Alice
          Alice->>John: Hello John, how are you?
          John-->>Alice: Great!
      {% endmermaid %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'

@diagrams
Feature: Syntrax

  As a liquid user, I want to use syntrax diagram

  Background:
    Given I have a liquid template with:
      """
      {% syntrax %}
      indentstack(10,
        line(opt('-'), choice('0', line('1-9', loop(None, '0-9'))),
          opt('.', loop('0-9', None))),
        line(opt(choice('e', 'E'), choice(None, '+', '-'), loop('0-9', None)))
      )
      {% endsyntrax %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'

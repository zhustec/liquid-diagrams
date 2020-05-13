@diagrams
Feature: Bitfield

  As a liquid user, I want to use bitfield diagram

  Background:
    Given I have a liquid template with:
      """
      {% bitfield %}
      [
        { "name": "IPO",   "bits": 8, "attr": "RO" },
        {                  "bits": 7 },
        { "name": "BRK",   "bits": 5, "attr": "RW", "type": 4 },
        { "name": "CPK",   "bits": 1 },
        { "name": "Clear", "bits": 3 },
        { "bits": 8 }
      ]
      {% endbitfield %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains 'viewBox="0 0 640 160"'

  Scenario: Configuration
    When I render it with 'bitfield' options:
      | hspace | 800 |
      | vspace | 100 |
    Then the output should contains 'viewBox="0 0 800 200"'

  Scenario: Inline options
    Given I have a liquid template with:
      """
      {% bitfield hspace=840 vspace=120 %}
      [
        { "name": "IPO",   "bits": 8, "attr": "RO" },
        {                  "bits": 7 },
        { "name": "BRK",   "bits": 5, "attr": "RW", "type": 4 },
        { "name": "CPK",   "bits": 1 },
        { "name": "Clear", "bits": 3 },
        { "bits": 8 }
      ]
      {% endbitfield %}
      """
    When I render it with 'bitfield' options:
      | hspace | 800 |
      | vspace | 100 |
    Then the output should contains 'viewBox="0 0 840 240"'

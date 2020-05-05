Feature: Smcat Rendering

  As a liquid user, I want to use smcat diagram

  Background:
    Given I have a liquid template with:
      """
      {% smcat %}
        playing {
          resting => walking;
          walking => resting;
        };

        playing => playing: ingest food;
        playing => playing [type=internal]: ingest drink;
      {% endsmcat %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'
    And the output should not contains '<\?xml'

@diagrams
Feature: Wavedrom

  As a liquid user, I want to use wavedrom diagram

  Background:
    Given I have a liquid template with:
      """
      {% wavedrom %}
      {
        signal: [
          { name: "clk",         wave: "p.....|..." },
          { name: "Data",        wave: "x.345x|=.x", data: ["head", "body", "tail", "data"] },
          { name: "Request",     wave: "0.1..0|1.0" },
          {},
          { name: "Acknowledge", wave: "1.....|01." }
        ]
      }
      {% endwavedrom %}
      """

  Scenario: Basic Rendering
    When I render it
    Then the output should contains '<svg'

Feature: Tests

Background:
    Given url base_url

Scenario: Get Specific Test
  Given path 'api/v2/tests/NIPT Pan'
  When method Get
  Then status 200

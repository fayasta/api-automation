Feature: Tests

Background:
    Given url base_url

    @regression
    Scenario: Get Specific Test
      Given path 'api/v2/tests/NIPT Pan'
      When method Get
      Then status 200

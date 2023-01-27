Feature: Labs

Background:
    Given url base_url

Scenario: Get Lab
  * def labId = labId
  Given path 'api/v2/labs/' + labId
  When method Get
  Then status 200

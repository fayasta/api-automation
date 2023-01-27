Feature: Get Cases

Background:
    Given url base_url

Scenario: Get Cases
  * def caseId = caseId
  Given path 'api/v2/cases/' + caseId
  When method Get
  Then status 200

Feature: Get Cases

Background:
    Given url base_url

    @regression @foundation @get_case
    Scenario: Get Cases
      * def caseId = caseId
      Given path 'api/v2/cases/' + caseId
      When method Get
      Then status 200

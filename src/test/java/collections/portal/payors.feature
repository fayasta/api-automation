Feature: Payors

Background:
    Given url base_url

Scenario: Get Payors
  Given path 'api/v2/insurance/'
  When method Get
  Then status 200

Scenario: Get Specific Payor - UHC //ToDo - Assertions
    * def insuranceId = insuranceId
    Given path 'api/v2/insurance/' + insuranceId
    When method Get
    Then status 200
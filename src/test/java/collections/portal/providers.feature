Feature: Providers

Background:
    Given url base_url

Scenario: Get Provider CY10000 //ToDo - Assertions
  * def clinicId = clinicId
  Given path 'api/v2/clinics/' + clinicId + '/providers'
  When method Get
  Then status 200

Feature: Clinics

Background:
    Given url base_url

Scenario: Get Clinic
  Given path 'api/v2/clinics'
  When method Get
  Then status 200

Scenario: Get Clinic CY10000 //ToDo - Assertions
    * def clinicId = clinicId
    Given path 'api/v2/clinics/' + clinicId
    When method Get
    Then status 200
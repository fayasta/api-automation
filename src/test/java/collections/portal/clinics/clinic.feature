Feature: Clinics

Background:
    Given url base_url

    @regression
    Scenario: Get Clinic
      Given path 'api/v2/clinics'
      When method Get
      Then status 200

    @regression @portal @clinic
    Scenario: Get Clinic CY10000 //ToDo - Assertions
        * def clinicId = clinicId
        * def timeValidatorRegex = read('classpath:helpers/JSValidators/DateValidatorFormat1.js')
        Given path 'api/v2/clinics/' + clinicId
        When method Get
        Then status 200
        And match response ==
        """
            {
                "clinicId":"#string",
                "practiceName":"#string",
                "taxId":"#string",
                "phoneNumber":"#string",
                "enrolledDate":"#string",
                "status":"#string",
                "providersLink":{
                    "link":"#string"
                }
            }
        """
        And match response.clinicId == "CY10000"
        And match response.practiceName == "McGlynn-O'Keefe"
        And match response.taxId == "8731480907290"
        And match response.phoneNumber == "4438468982"
        And match response.enrolledDate == "2022-02-16"
        And match response.status == "active"
        And match response.providersLink.link == "/api/v2/clinics/CY10000/providers"
          # Double ## means optional
          # #? means can be null
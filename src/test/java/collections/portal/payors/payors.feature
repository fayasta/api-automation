Feature: Payors

Background:
    Given url base_url

    @regression @portal @payors
    Scenario: Get Payors
      Given path 'api/v2/insurance/'
      When method Get
      Then status 200

    @regression @portal @payors
    Scenario: Get Specific Payor - UHC //ToDo - Assertions
        * def insuranceId = insuranceId
        * def timeValidatorRegex = read('classpath:helpers/JSValidators/DateValidatorFormat2.js')
        Given path 'api/v2/insurance/' + insuranceId
        When method Get
        Then status 200
        And match response ==
        """
            {
                "insuranceName":"#string",
                "insuranceId":"#string",
                "createdDate":"#? timeValidatorRegex(_)",
                "updatedDate":"#? timeValidatorRegex(_)",
                "aliases":"#array",
                "active":"#boolean",
            }
        """
        And match response.insuranceName == "United Healthcare"
        And match response.insuranceId == "qm7wys0ag"
        And match response.createdDate == "2019-01-24T12:22:33-05:00"
        And match response.updatedDate == "2022-10-04T13:35:52-04:00"
        And match response.aliases[0] == "UHC"
        And match response.active == true
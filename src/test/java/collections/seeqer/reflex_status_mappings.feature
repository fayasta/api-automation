Feature: Reflex Status Mappings

Background: Base Url
    Given url base_url
    * def seeqer_reflex_status_mappings_body = read('classpath:collections/seeqer/jsons/reflex_status_mappings.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_reflex_status_mappings_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set seeqer_reflex_status_mappings_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @regression
    Scenario: Post Reflex Status Mappings
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        * def timeValidatorRegex = read('classpath:helpers/JSValidators/DateValidatorFormat1.js')
        * def timeValidatorRegex2 = read('classpath:helpers/JSValidators/DateValidatorFormat2.js')
        Given path 'api/v2/cases'
        And request seeqer_reflex_status_mappings_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201
        * def SQ_caseId_ReflexStatusMapping = response.caseId
        * eval sleep(5000)
        Given path 'api/v2/cases/' + SQ_caseId_ReflexStatusMapping
        When method Get
        Then assert responseStatus == 200 || responseStatus == 201
        And match response ==
        """
            {
                "caseId":"#string",
                "caseType":"#string",
                "source":"#string",
                "associatedCases":"#array",
                "closed":"#boolea",
                "labId":"#string",
                "labName":"#string",
                "labClinicId":"#string",
                "createdAt":"# timeValidatorRegex2(_)",
                "postServiceReview":false,
                "patient":{
                    "patientId":"#string",
                    "firstName":"#string",
                    "middleName":"#?string",
                    "lastName":"#string",
                    "gender":"#string",
                    "phoneNumber":"#string",
                    "dob":"# timeValidatorRegex1(_)",
                    "street":"#string",
                    "street2":"#string",
                    "city":"#string",
                    "state":"#string",
                    "zip":"#string"
                },
                "provider":{
                    "externalProviderId":"#?string",
                    "practiceName":"#string",
                    "firstName":"#string",
                    "lastName":"#string",
                    "npi":"#string",
                    "phoneNumber":"#string",
                    "faxNumber":"#string"
                },
                "clinic":{
                    "clinicId":"#string",
                    "clinicName":"#string"
                },
                "test":{
                    "testNames":"#array",
                    "optumTestNames":"#array",
                    "testIdentifiers":"#array",
                    "cptCodes":"#array",
                    "testType":""
                },
                "primaryInsurance":{
                    "insuranceName":"#string",
                    "groupId":"#string",
                    "planId":"#string",
                    "memberId":"#string"
                },
                "labOrder":{
                    "labOrderId":"#string",
                    "collectionType":"#string",
                    "collectionDate":"# timeValidatorRegex1(_)",
                    "serviceDate":"# timeValidatorRegex2(_)",
                    "accessionDate":"# timeValidatorRegex2(_)",
                    "icd10Codes":"#array"
                },
                "supplementalDocuments":"#array",
                "attachments":"#array",
                "results":{
                    "status":"#string",
                    "verifiedInsurance":{
                        "insuranceId":"#string",
                        "insuranceName":"#string",
                        "memberId":"#string"
                    },
                    "coverageActive":"#boolean",
                    "cptCodeDetails":"#array"
                    }
                }
        """
        And match response.caseId !contains ""
        And match response.associatedCases == "#[0]"

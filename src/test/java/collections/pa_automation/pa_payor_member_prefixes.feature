Feature: PA Request - Payor Member Prefixes

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_payor_member_prefixes_body = read('classpath:collections/pa_automation/jsons/pa_payor_member_prefixes.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_payor_member_prefixes_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_payor_member_prefixes_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @regression
    Scenario: Post - PA Request - Payor Member Prefixes
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        * def timeValidatorRegex = read('classpath:helpers/JSValidators/DateValidatorFormat1.js')
        * def timeValidatorRegex2 = read('classpath:helpers/JSValidators/DateValidatorFormat2.js')
        Given path 'api/v2/cases'
        And request pa_payor_member_prefixes_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201
        * def pa_payor_member_prefixes_case_id = response.caseId
        * eval sleep(5000)
        Given path 'api/v2/cases/' + pa_payor_member_prefixes_case_id
        When method Get
        Then assert responseStatus == 200 || responseStatus == 201
        And match response ==
        """
        {
            "caseId":"#string",
            "caseType":"#string",
            "source":"#string",
            "associatedCases":"#array",
            "closed":"#boolean",
            "labId":"#string",
            "labName":"#string",
            "labClinicId":"#string",
            "notes":"#string",
            "createdAt":"# timeValidatorRegex2(_)",
            "postServiceReview":"#boolean",
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
            "otherClinicalInfo":"#string",
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
               "optumClinicName":"#string",
               "clinicName":"#string"
            },
            "test":{
               "testNames":"#array",
               "optumTestNames":"#array",
               "testIdentifiers":"#array",
               "cptCodes":"#array",
               "testType":"#string"
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
               "icd10Codes":[
                  "#string"
               ]
            },
            "supplementalDocuments":[
               {
                  "documentId":"#string",
                  "mimeType":"#string"
               }
            ],
            "attachments":[
               {
                  "id":"#string",
                  "link":"#string",
                  "type":"#string",
                  "category":"#string",
                  "mimeType":"#string"
               }
            ],
            "results":{
               "status":"#string",
               "verifiedInsurance":{
                  "insuranceId":"#string",
                  "insuranceName":"#string",
                  "memberId":"#string"
               },
               "authorizedCptCodes":"#array"
            }
         }
         """
        And match response.results.status == "received"
        And match response.results.verifiedInsurance.insuranceId == "2x7seongi"
        And match response.results.verifiedInsurance.insuranceName == "CareSource of Ohio"
        And match response.results.verifiedInsurance.memberId == "HJK5421232"
        And match response != []
        And match response !contains "error"

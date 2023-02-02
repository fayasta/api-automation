Feature: PA Request - Insurance Payor Mapping

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_insurance_payor_mapping_body = read('classpath:collections/pa_automation/jsons/pa_insurance_payor_mapping.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_insurance_payor_mapping_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_insurance_payor_mapping_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @regression
    Scenario: Post - PA Request - Insurance Payor Mapping
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        * def timeValidatorRegex = read('classpath:helpers/JSValidators/DateValidatorFormat1.js')
        * def timeValidatorRegex2 = read('classpath:helpers/JSValidators/DateValidatorFormat2.js')
        * def timeValidatorRegex3 = read('classpath:helpers/JSValidators/DateValidatorFormat3.js')
        Given path 'api/v2/cases'
        And request pa_insurance_payor_mapping_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201
        * def pa_insurance_payor_mapping_case_id = response.caseId
        * eval sleep(5000)
        Given path 'api/v2/cases/' + pa_insurance_payor_mapping_case_id
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
            "createdAt":"# timeValidatorRegex3(_)",
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
        And match response.results.verifiedInsurance.insuranceId == "qm7wys0ag"
        And match response.results.verifiedInsurance.insuranceName == "United Healthcare"
        And match response.results.verifiedInsurance.memberId == "3211233212"
        And match response != []
        And match response !contains "error"

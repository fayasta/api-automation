Feature: PA Request - Status Mapping - Rejected

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_status_mapping_rejected_body = read('classpath:collections/pa_automation/jsons/pa_status_mapping_rejected.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_status_mapping_rejected_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_status_mapping_rejected_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @post-precondition
    Scenario: Post - PA Request - Status Mapping - Rejected
        Given path 'api/v2/cases'
        And request pa_status_mapping_rejected_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201


    @regression @pa_automation @pa_status_mapping_rejected
    Scenario: Get - PA Request - Status Mapping - Rejected
      * def sleep = function(pause){java.lang.Thread.sleep(pause)}
      * def timeValidatorRegex1 = read('classpath:helpers/JSValidators/DateValidatorFormat1.js')
      * def timeValidatorRegex2 = read('classpath:helpers/JSValidators/DateValidatorFormat2.js')
      * def timeValidatorRegex3 = read('classpath:helpers/JSValidators/DateValidatorFormat3.js')
      * def postResponse = karate.callSingle('classpath:collections/pa_automation/pa_status_mapping_rejected.feature@post-precondition').response
      * def pa_status_mapping_rejected_case_id = postResponse.caseId
      Given path 'api/v2/cases/' + pa_status_mapping_rejected_case_id
      When method Get
      * eval sleep(10000)
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
             "icd10Codes":"#array"
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
      And match response.results.status == "rejected"
      And match response.results.verifiedInsurance.insuranceId == "qm7wys0ag"
      And match response.results.verifiedInsurance.insuranceName == "United Healthcare"
      And match karate.toString(response) !contains "error"
      And match karate.toString(response) != ""


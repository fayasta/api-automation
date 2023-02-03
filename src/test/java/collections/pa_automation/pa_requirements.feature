Feature: PA Request - Requirements

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_requirement_body = read('classpath:collections/pa_automation/jsons/pa_requirement.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_requirement_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_requirement_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @post-precondition
    Scenario: Post - PA Request - Requirements
        Given path 'api/v2/cases'
        And request pa_requirement_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201

    @regression @pa_automation @get_pa_requirements
    Scenario: Get - PA Request - Requirements
      * def sleep = function(pause){java.lang.Thread.sleep(pause)}
      * def timeValidatorRegex = read('classpath:helpers/JSValidators/DateValidatorFormat1.js')
      * def timeValidatorRegex2 = read('classpath:helpers/JSValidators/DateValidatorFormat2.js')
      * def timeValidatorRegex3 = read('classpath:helpers/JSValidators/DateValidatorFormat3.js')
      * def postResponse = karate.callSingle('classpath:collections/pa_automation/pa_requirements.feature@post-precondition').response
      * def pa_requirement_case_id = postResponse.caseId
      Given path 'api/v2/cases/' + pa_requirement_case_id
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
      And match response.results.status == "not_required"
      And match response.results.verifiedInsurance.insuranceId == "qm7wys0ag"
      #pending to add sub status
      And match response.results.verifiedInsurance.insuranceName == "United Healthcare"
      And match response.results.verifiedInsurance.memberId == "3211233212"
      And match karate.toString(response) !contains "error"
      And match karate.toString(response) != ""

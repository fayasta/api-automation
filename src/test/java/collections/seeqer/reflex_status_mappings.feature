Feature: Reflex Status Mappings

Background: Base Url
    Given url base_url
    * def seeqer_reflex_status_mappings_body = read('classpath:collections/seeqer/jsons/reflex_status_mappings.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_reflex_status_mappings_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set seeqer_reflex_status_mappings_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @post-precondition
    Scenario: Post Reflex Status Mappings

        Given path 'api/v2/cases'
        And request seeqer_reflex_status_mappings_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201
        
    @regression @seeqer @reflex_status_mapping
    Scenario: Get Reflex Status Mapping
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        * def postResponse = karate.callSingle('classpath:collections/seeqer/reflex_status_mappings.feature@post-precondition').response
        * def SQ_caseId_ReflexStatusMapping = postResponse.caseId
        * def timeValidatorRegex = read('classpath:helpers/JSValidators/DateValidatorFormat1.js')
        * def timeValidatorRegex2 = read('classpath:helpers/JSValidators/DateValidatorFormat2.js')
        * def timeValidatorRegex3 = read('classpath:helpers/JSValidators/DateValidatorFormat3.js')
        Given path 'api/v2/cases/' + SQ_caseId_ReflexStatusMapping
        When method Get
        * eval sleep(10000)
        Then assert responseStatus == 200 || responseStatus == 201
        # And match response ==
        # """
        #         {
        #             "caseId":"#string",
        #             "caseType":"#string",
        #             "source":"#string",
        #             "associatedCases":"#array",
        #             "closed":"#boolean",
        #             "labId":"#string",
        #             "labName":"#string",
        #             "labClinicId":"#string",
        #             "notes":"#string",
        #             "createdAt":"#string",
        #             "postServiceReview":"#boolean",
        #             "patient":{
        #                 "patientId":"#string",
        #                 "firstName":"#string",
        #                 "middleName":"#string",
        #                 "lastName":"#string",
        #                 "gender":"#string",
        #                 "phoneNumber":"#string",
        #                 "dob":"#string",
        #                 "street":"#string",
        #                 "street2":"#string",
        #                 "city":"#string",
        #                 "state":"#string",
        #                 "zip":"#string"
        #             },
        #             "provider":{
        #                 "externalProviderId":"#?string",
        #                 "practiceName":"#string",
        #                 "firstName":"#string",
        #                 "lastName":"#string",
        #                 "npi":"#string",
        #                 "phoneNumber":"#string",
        #                 "faxNumber":"#string"
        #             },
        #             "clinic":{
        #                 "clinicId":"#string",
        #                 "clinicName":"#string"
        #             },
        #             "test":{
        #                 "testNames":"#array",
        #                 "optumTestNames":"#array",
        #                 "testIdentifiers":"#array",
        #                 "cptCodes":"#array",
        #                 "testType":"#string"
        #             },
        #             "primaryInsurance":{
        #                 "insuranceName":"#string",
        #                 "groupId":"#string",
        #                 "planId":"#string",
        #                 "memberId":"#string"
        #             },
        #             "labOrder":{
        #                 "labOrderId":"#string",
        #                 "collectionType":"#string",
        #                 "collectionDate":"#string",
        #                 "serviceDate":"#string",
        #                 "accessionDate":"#string",
        #                 "icd10Codes":"#array"
        #             },
        #             "supplementalDocuments":"#array",
        #             "attachments":"#array",
        #             "results":{
        #                 "status":"#string",
        #                 "verifiedInsurance":{
        #                     "insuranceId":"#string",
        #                     "insuranceName":"#string",
        #                     "memberId":"#string"
        #                 },
        #                 "coverageActive":"#boolean",
        #                 "copay":"#string",
        #                 "coinsurance":"#number",
        #                 "effectiveDate":"#string",
        #                 "inNetwork":"#boolean",
        #                 "paRequired":"#boolean",
        #                 "maxOutOfPocketRemaining":"#string",
        #                 "deductibleRemaining":"#string",
        #                 "cptCodeDetails":"#array",
        #                 "estimatedTotalPatientResponsibility":"#string"
        #                 }
        #             }
        # """
        And match response.associatedCases == "#[0]"

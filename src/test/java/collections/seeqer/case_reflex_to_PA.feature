Feature: Case Reflex to a PA

Background: Base Url
    Given url base_url
    * def seeqer_case_reflex_to_pa_body = read('classpath:collections/seeqer/jsons/case_reflex_to_pa.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_case_reflex_to_pa_body.labOrder.labOrderId = dataGenerator.getRandomLaborOrderId()
    * set seeqer_case_reflex_to_pa_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set seeqer_case_reflex_to_pa_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post Case Reflex to PA
        Given path 'api/v2/cases'
        And request seeqer_case_reflex_to_pa_body
        #**************Positive scenarios**************
        # In this section we can add:
        # Status Code verifications, Getting correct values in the response 
        When method Post
        Then assert responseStatus == 201

    @regression @seeqer @case_reflex
    Scenario: Get Case Reflex to PA
        * configure retry = { count: 4, interval: 5000 }
        * def postResponse = karate.callSingle('classpath:collections/seeqer/case_reflex_to_PA.feature@post-precondition').response
        * def SQ_case_id = postResponse.caseId
        Given path 'api/v2/cases/' + SQ_case_id
        And retry until response.closed == true
        When method Get
        Then assert responseStatus == 200
        #**************Positive scenarios**************
        # In this section we can add:
        # Status Code verifications, Getting correct values in the response 
        * def validate_schema = call read("classpath:feature_helpers/schema_get_case_id.feature") response
        And match response.closed == true
        And match response.associatedCases[0].type == "relates_to"
        And match response.associatedCases[0].type == "#string"
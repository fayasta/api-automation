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
        #**************Positive scenarios**************
        # In this section we can add:
        # Status Code verifications, Getting correct values in the response 
        Then assert responseStatus == 201

        
    @regression @seeqer @reflex_status_mapping
    Scenario: Get Reflex Status Mapping
        * configure retry = { count: 4, interval: 5000 }
        * def postResponse = karate.callSingle('classpath:collections/seeqer/reflex_status_mappings.feature@post-precondition').response
        * def SQ_caseId_ReflexStatusMapping = postResponse.caseId
        Given path 'api/v2/cases/' + SQ_caseId_ReflexStatusMapping
        And retry until response.results.status == "closed"
        When method Get
        #**************Positive scenarios**************
        # In this section we can add:
        # Status Code verifications, Getting correct values in the response 
        Then assert responseStatus == 200
        * def validate_schema = call read("classpath:feature_helpers/schema_get_case_id.feature") response
        And match response.associatedCases == "#[0]"

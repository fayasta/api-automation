Feature: Out of Network

Background: Base Url
    Given url base_url
    * def seeqer_out_of_network_body = read('classpath:collections/seeqer/jsons/out_of_network.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_out_of_network_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set seeqer_out_of_network_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post SeeQer Out of Network
        Given path 'api/v2/cases'
        And request seeqer_out_of_network_body
        #**************Positive scenarios**************
        # In this section we can add:
        # Status Code verifications, Getting correct values in the response 
        When method Post
        Then assert responseStatus == 201

    @regression @seeqer @out_of_network
    Scenario: Get SeeQer Out of Network
        * configure retry = { count: 4, interval: 5000 }
        * def postResponse = karate.callSingle('classpath:collections/seeqer/out_of_network.feature@post-precondition').response
        * def out_of_network_case_id = postResponse.caseId
        Given path 'api/v2/cases/' + out_of_network_case_id
        And retry until response.closed == true
        When method Get
        #**************Positive scenarios**************
        # In this section we can add:
        # Status Code verifications, Getting correct values in the response 
        Then assert responseStatus == 200
        * def validate_schema = call read("classpath:feature_helpers/schema_get_case_id.feature") response
        And match response.closed == true
        And match response.results.coverageActive == true
        And match response.results.estimatedTotalPatientResponsibility == "$323.00" 
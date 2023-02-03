Feature: Out of Network

Background: Base Url
    Given url base_url
    * def seeqer_out_of_network_body = read('classpath:collections/seeqer/jsons/out_of_network.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_out_of_network_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set seeqer_out_of_network_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @post-precondition
    Scenario: Post SeeQer Out of Network
        Given path 'api/v2/cases'
        And request seeqer_out_of_network_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201

    @regression @seeqer @out_of_network
    Scenario: Get SeeQer Out of Network
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        * def postResponse = karate.callSingle('classpath:collections/seeqer/out_of_network.feature@post-precondition').response
        * def out_of_network_case_id = postResponse.caseId
        Given path 'api/v2/cases/' + out_of_network_case_id
        When method Get
        * eval sleep(15000)
        Then assert responseStatus == 200 || responseStatus == 201
        And match response.closed == true
        And match response.results.estimatedTotalPatientResponsibility == "$3.13"
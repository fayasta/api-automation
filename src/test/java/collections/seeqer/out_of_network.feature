Feature: Out of Network

Background: Base Url
    Given url base_url
    * def seeqer_out_of_network_body = read('classpath:collections/seeqer/jsons/out_of_network.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_out_of_network_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set seeqer_out_of_network_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @regression
    Scenario: Post SeeQer Out of Network
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        Given path 'api/v2/cases'
        And request seeqer_out_of_network_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201
        * def out_of_network_case_id = response.caseId
        * eval sleep(10000)
        Given path 'api/v2/cases/' + out_of_network_case_id
        When method Get
        Then assert responseStatus == 200 || responseStatus == 201
        And match response.closed == true
        And match response contains "closed"
        And match response contains "closed"
        #Ademas de ser incorrecto, por que necesitas validar dos veces el closed? en Status: Closed & Active Coverage: True
        And match response contains "$3.13"

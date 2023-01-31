Feature: Reflex Status Mappings

Background: Base Url
    Given url base_url
    * def seeqer_reflex_status_mappings_body = read('classpath:collections/seeqer/jsons/reflex_status_mappings.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_reflex_status_mappings_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set seeqer_reflex_status_mappings_body.labOrder.serviceDate = dataGenerator.getRandomDate()

Scenario: Post Reflex Status Mappings
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    Given path 'api/v2/cases'
    And request seeqer_reflex_status_mappings_body
    When method Post
    Then assert responseStatus == 200 || responseStatus == 201
    * def SQ_caseId_ReflexStatusMapping = response.caseId
    * eval sleep(5000)
    Given path 'api/v2/cases/' + SQ_caseId_ReflexStatusMapping
    When method Get
    Then assert responseStatus == 200 || responseStatus == 201
    # ToDo add additional Asserts

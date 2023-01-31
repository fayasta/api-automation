Feature: Case Reflex to a PA

Background: Base Url
    Given url base_url
    * def seeqer_case_reflex_to_pa_body = read('classpath:collections/seeqer/jsons/case_reflex_to_pa.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_case_reflex_to_pa_body.labOrder.labOrderId = dataGenerator.getRandomLaborOrderId()
    * set seeqer_case_reflex_to_pa_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set seeqer_case_reflex_to_pa_body.labOrder.serviceDate = dataGenerator.getRandomDate()

Scenario: Post Case Reflex to PA
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    Given path 'api/v2/cases'
    And request seeqer_case_reflex_to_pa_body
    When method Post
    Then assert responseStatus == 200 || responseStatus == 201
    * def SQ_caseId_PA_caseReflex = response.caseId
    * eval sleep(5000)
    Given path 'api/v2/cases/' + SQ_caseId_PA_caseReflex
    When method Get
    Then assert responseStatus == 200 || responseStatus == 201
# ToDo add additional Asserts

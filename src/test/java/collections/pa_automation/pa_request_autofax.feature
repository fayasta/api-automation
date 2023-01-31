Feature: PA Request - Autofax

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_request_autofax_body = read('classpath:collections/pa_automation/jsons/pa_request_autofax.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_request_autofax_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_request_autofax_body.labOrder.serviceDate = dataGenerator.getRandomDate()

Scenario: Post - PA Request - Autofax
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    Given path 'api/v2/cases'
    And request pa_request_autofax_body
    When method Post
    Then assert responseStatus == 200 || responseStatus == 201
    * def pa_request_autofax_case_id = response.caseId
    * eval sleep(3000)
    Given path 'api/v2/cases/' + pa_request_autofax_case_id
    When method Get
    Then assert responseStatus == 200 || responseStatus == 201
# ToDo add additional Asserts

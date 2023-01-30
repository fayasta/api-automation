Feature: PA Request - Requirements

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_requirement_body = read('classpath:collections/pa_automation/jsons/pa_requirement.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_requirement_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_requirement_body.labOrder.serviceDate = dataGenerator.getRandomDate()

Scenario: Post - PA Request - Requirements
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    Given path 'api/v2/cases'
    And request pa_requirement_body
    When method Post
    Then assert responseStatus == 200 || responseStatus == 201
    * def pa_requirement_case_id = respose.caseId
    * eval sleep(3000)
    Given path 'api/v2/cases/' + pa_requirement_case_id
    When method Get
    Then assert responseStatus == 200 || responseStatus == 201
# ToDo add additional Asserts

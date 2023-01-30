Feature: PA Request - Test Mapping

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_test_mapping_body = read('classpath:collections/pa_automation/jsons/pa_test_mapping.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_test_mapping_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_test_mapping_body.labOrder.serviceDate = dataGenerator.getRandomDate()

Scenario: Post - PA Request - Test Mapping
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    Given path 'api/v2/cases'
    And request pa_test_mapping_body
    When method Post
    Then assert responseStatus == 200 || responseStatus == 201
    * def pa_test_mapping_case_id = respose.caseId
    * eval sleep(5000)
    Given path 'api/v2/cases/' + pa_test_mapping_case_id
    When method Get
    Then assert responseStatus == 200 || responseStatus == 201
# ToDo add additional Asserts

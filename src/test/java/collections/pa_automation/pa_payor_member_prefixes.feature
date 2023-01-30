Feature: PA Request - Payor Member Prefixes

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_payor_member_prefixes_body = read('classpath:collections/pa_automation/jsons/pa_payor_member_prefixes.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_payor_member_prefixes_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_payor_member_prefixes_body.labOrder.serviceDate = dataGenerator.getRandomDate()

Scenario: Post - PA Request - Payor Member Prefixes
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    Given path 'api/v2/cases'
    And request pa_payor_member_prefixes_body
    When method Post
    Then assert responseStatus == 200 || responseStatus == 201
    * def pa_payor_member_prefixes_case_id = respose.caseId
    * eval sleep(5000)
    Given path 'api/v2/cases/' + pa_payor_member_prefixes_case_id
    When method Get
    Then assert responseStatus == 200 || responseStatus == 201
# ToDo add additional Asserts

Feature: Payor Auto Approval

Background: Base Url and cofigure json body
    Given url base_url
    * def payor_auto_approval_body = read('classpath:collections/pa_automation/jsons/payor_auto_approval.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set payor_auto_approval_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set payor_auto_approval_body.labOrder.serviceDate = dataGenerator.getRandomDate()

Scenario: Post - Payor Auto Approval
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    Given path 'api/v2/cases'
    And request payor_auto_approval_body
    When method Post
    Then assert responseStatus == 200 || responseStatus == 201
    * def payor_auto_approval_case_id = response.caseId
    * eval sleep(5000)
    Given path 'api/v2/cases/' + payor_auto_approval_case_id
    When method Get
    Then assert responseStatus == 200 || responseStatus == 201
# ToDo add additional Asserts

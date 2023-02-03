Feature: Payor Auto Approval

Background: Base Url and cofigure json body
    Given url base_url
    * def payor_auto_approval_body = read('classpath:collections/pa_automation/jsons/payor_auto_approval.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set payor_auto_approval_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set payor_auto_approval_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @post-precondition
    Scenario: Post - Payor Auto Approval
        Given path 'api/v2/cases'
        And request payor_auto_approval_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201

    @regression @pa_automation @payor_auto_approval
    Scenario: Get - Payor Auto Approval
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        * def postResponse = karate.callSingle('classpath:collections/pa_automation/payor_auto_approval.feature@post-precondition').response
        * def payor_auto_approval_case_id = postResponse.caseId
        Given path 'api/v2/cases/' + payor_auto_approval_case_id
        When method Get
        * eval sleep(10000)
        Then assert responseStatus == 200 || responseStatus == 201
        And match response.results.status == "approved"
        And match response.closed == true

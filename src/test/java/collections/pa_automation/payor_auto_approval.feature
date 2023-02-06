Feature: Payor Auto Approval

Background: Base Url and cofigure json body
    Given url base_url
    * def payor_auto_approval_body = read('classpath:collections/pa_automation/jsons/payor_auto_approval.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set payor_auto_approval_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set payor_auto_approval_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post - Payor Auto Approval
        Given path 'api/v2/cases'
        And request payor_auto_approval_body
        When method Post
        Then assert responseStatus == 201

    @regression @pa_automation @payor_auto_approval
    Scenario: Get - Payor Auto Approval
        * configure retry = { count: 4, interval: 5000 }
        * def postResponse = karate.callSingle('classpath:collections/pa_automation/payor_auto_approval.feature@post-precondition').response
        * def payor_auto_approval_case_id = postResponse.caseId
        Given path 'api/v2/cases/' + payor_auto_approval_case_id
        And retry until response.results.status == "approved"
        When method Get
        Then assert responseStatus == 200
        And match response.results.status == "approved"
        And match response.closed == true

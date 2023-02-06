Feature: PA Request - PVerify - Not Required

Background: Base Url and cofigure json body
    Given url base_url
    * def pverify_not_required_body = read('classpath:collections/pa_automation/jsons/pverify_not_required.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pverify_not_required_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set pverify_not_required_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post - PA Request - PVerify - Not Required
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        Given path 'api/v2/cases'
        And request pverify_not_required_body
        When method Post
        Then assert responseStatus == 201

    @regression @pa_automation @pverify_not_required
    Scenario: Get - PA Request - PVerify - Not Required
        * configure retry = { count: 4, interval: 5000 }
        * def postResponse = karate.callSingle('classpath:collections/pa_automation/pverify_not_required.feature@post-precondition').response
        * def not_required_case_id = postResponse.caseId
        Given path 'api/v2/cases/' + not_required_case_id
        And retry until response.results.status == "not_required"
        When method Get
        Then assert responseStatus == 200
        And match response.results.status == "not_required"
        And match response.closed == true

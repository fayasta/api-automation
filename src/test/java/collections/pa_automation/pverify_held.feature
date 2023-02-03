Feature: PA Request - PVerify - HELD Payor Status Mapping

Background: Base Url and cofigure json body
    Given url base_url
    * def pverify_held_body = read('classpath:collections/pa_automation/jsons/pverify_held.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pverify_held_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pverify_held_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @post-precondition
    Scenario: Post - PA Request - PVerify - HELD 
        Given path 'api/v2/cases'
        And request pverify_held_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201

    @regression @pa_automation @pverify_held
    Scenario: Get - PA Request - PVerify - HELD 
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        * def postResponse = karate.callSingle('classpath:collections/pa_automation/pverify_held.feature@post-precondition').response
        * def held_case_id = postResponse.caseId
        Given path 'api/v2/cases/' + held_case_id
        When method Get
        * eval sleep(5000)
        Then assert responseStatus == 200 || responseStatus == 201
        And match response.results.status == "held"


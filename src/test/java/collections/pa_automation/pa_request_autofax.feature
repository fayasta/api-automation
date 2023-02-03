Feature: PA Request - Autofax

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_request_autofax_body = read('classpath:collections/pa_automation/jsons/pa_request_autofax.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_request_autofax_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_request_autofax_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @post-precondition
    Scenario: Post - PA Request - Autofax
        Given path 'api/v2/cases'
        And request pa_request_autofax_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201
        
    @regression @pa_automation @pa_request_autofax
    Scenario: Get - PA Request - Autofax
        * configure retry = { count: 4, interval: 5000 }
        * def postResponse = karate.callSingle('classpath:collections/pa_automation/pa_request_autofax.feature@post-precondition').response
        * def pa_request_autofax_case_id = postResponse.caseId
        Given path 'api/v2/cases/' + pa_request_autofax_case_id
        And retry until response.results.status == "submitted"
        When method Get
        Then assert responseStatus == 200 || responseStatus == 201
        And match response.results.status == "submitted"

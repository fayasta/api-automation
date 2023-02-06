Feature: PA Request - Auto Status - Rejected

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_request_auto_rejected_body = read('classpath:collections/pa_automation/jsons/pa_request_auto_rejected.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_request_auto_rejected_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set pa_request_auto_rejected_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post - PA Request - Auto Status - Rejected
        Given path 'api/v2/cases'
        And request pa_request_auto_rejected_body
        When method Post
        Then assert responseStatus == 201

    @regression @pa_automation @pa_request_auto_status_rejected
    Scenario: Get - PA Request - Auto Status - Rejected
        * configure retry = { count: 4, interval: 5000 }
        * def postResponse = karate.callSingle('classpath:collections/pa_automation/pa_request_auto_status_rejected.feature@post-precondition').response
        * def pa_request_auto_rejected_case_id = postResponse.caseId
        Given path 'api/v2/cases/' + pa_request_auto_rejected_case_id
        And retry until response.results.status == "rejected"
        When method Get
        Then assert responseStatus == 200
        And match response.results.status == "rejected"


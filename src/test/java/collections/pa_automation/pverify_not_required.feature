Feature: PA Request - PVerify - Not Required

Background: Base Url and cofigure json body
    Given url base_url
    * def pverify_not_required_body = read('classpath:collections/pa_automation/jsons/pverify_not_required.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pverify_not_required_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pverify_not_required_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @regression
    Scenario: Post - PA Request - PVerify - Not Required
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        Given path 'api/v2/cases'
        And request pverify_not_required_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201
        * def not_required_case_id = response.caseId
        * eval sleep(5000)
        Given path 'api/v2/cases/' + not_required_case_id
        When method Get
        Then assert responseStatus == 200 || responseStatus == 201
        And match response.results.status == "not_required"
        And match response.closed == true

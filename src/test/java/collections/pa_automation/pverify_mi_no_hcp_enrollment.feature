Feature: PA Request - PVerify - MI: NO HCP Enrollmet

Background: Base Url and cofigure json body
    Given url base_url
    * def pverify_mi_no_hcp_enrollment_body = read('classpath:collections/pa_automation/jsons/pverify_mi_no_hcp_enrollment.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pverify_mi_no_hcp_enrollment_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pverify_mi_no_hcp_enrollment_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @post-precondition
    Scenario: Post - PA Request - MI: NO HCP Enrollmet
        Given path 'api/v2/cases'
        And request pverify_mi_no_hcp_enrollment_body
        When method Post

    @regression @pa_automation @pverify_mi_no_hcp_enrollment
    Scenario: Get - PA Request - MI: NO HCP Enrollmet
        * configure retry = { count: 4, interval: 5000 }
        * def postResponse = karate.callSingle('classpath:collections/pa_automation/pverify_mi_no_hcp_enrollment.feature@post-precondition').response
        * def no_hcp_enrollment_case_id = postResponse.caseId
        Given path 'api/v2/cases/' + no_hcp_enrollment_case_id
        And retry until response.results.status == "missinginfo"
        When method Get
        Then assert responseStatus == 200 || responseStatus == 201
        And match response.results.status == "missinginfo"
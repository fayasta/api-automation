Feature: PA Request - Status Mapping - Rejected

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_status_mapping_rejected_body = read('classpath:collections/pa_automation/jsons/pa_status_mapping_rejected.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_status_mapping_rejected_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set pa_status_mapping_rejected_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post - PA Request - Status Mapping - Rejected
        Given path 'api/v2/cases'
        And request pa_status_mapping_rejected_body
        When method Post
        Then assert responseStatus == 201


    @regression @pa_automation @pa_status_mapping_rejected
    Scenario: Get - PA Request - Status Mapping - Rejected
      * configure retry = { count: 4, interval: 5000 }
      * def postResponse = karate.callSingle('classpath:collections/pa_automation/pa_status_mapping_rejected.feature@post-precondition').response
      * def pa_status_mapping_rejected_case_id = postResponse.caseId
      Given path 'api/v2/cases/' + pa_status_mapping_rejected_case_id
      And retry until response.results.status == "rejected"
      When method Get
      Then assert responseStatus == 200
      * def validate_schema = call read("classpath:feature_helpers/schema_get_case_id.feature") response
      And match response.results.status == "rejected"
      And match response.results.verifiedInsurance.insuranceId == "qm7wys0ag"
      And match response.results.verifiedInsurance.insuranceName == "United Healthcare"
      And match karate.toString(response) !contains "error"
      And match karate.toString(response) != ""


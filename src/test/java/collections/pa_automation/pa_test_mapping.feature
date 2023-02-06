Feature: PA Request - Test Mapping

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_test_mapping_body = read('classpath:collections/pa_automation/jsons/pa_test_mapping.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_test_mapping_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set pa_test_mapping_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post - PA Request - Test Mapping
        Given path 'api/v2/cases'
        And request pa_test_mapping_body
        When method Post
        Then assert responseStatus == 201

    @regression @pa_automation @pa_test_mapping
   Scenario: Get - PA Request - Test Mapping
      * configure retry = { count: 4, interval: 5000 }
      * def postResponse = karate.callSingle('classpath:collections/pa_automation/pa_test_mapping.feature@post-precondition').response
      * def pa_test_mapping_case_id = postResponse.caseId
      Given path 'api/v2/cases/' + pa_test_mapping_case_id
      And retry until response.test.testNames[0] == "NIPT Panorama"
      When method Get
      Then assert responseStatus == 200
      * def validate_schema = call read("classpath:feature_helpers/schema_get_case_id.feature") response
      And match response.test.testNames[0] == "NIPT Panorama"
      And match response.test.optumTestNames[0] == "NIPT Panorama Optum Test"
      And match response.test.testIdentifiers[0] == "NIPT Pan"
      And match response.test.cptCodes[0] == "0013M"
      And match response.test.testType == "NIPT"
      And match karate.toString(response) !contains "error"
      And match karate.toString(response) != ""

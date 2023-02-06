Feature: PA Request - Insurance Payor Mapping

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_insurance_payor_mapping_body = read('classpath:collections/pa_automation/jsons/pa_insurance_payor_mapping.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_insurance_payor_mapping_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set pa_insurance_payor_mapping_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post - PA Request - Insurance Payor Mapping
        Given path 'api/v2/cases'
        And request pa_insurance_payor_mapping_body
        When method Post
        Then assert responseStatus == 201

    @regression @pa_automation @insurannce_payor_mapping
    Scenario: Get - PA Request - Insurance Payor Mapping
      * configure retry = { count: 4, interval: 5000 }
      * def postResponse = karate.callSingle('classpath:collections/pa_automation/pa_insurance_payor_mapping.feature@post-precondition').response
      * def pa_insurance_payor_mapping_case_id = postResponse.caseId
      Given path 'api/v2/cases/' + pa_insurance_payor_mapping_case_id
      And retry until response.results.status == "received"
      When method Get
      Then assert responseStatus == 200
      * def validate_schema = call read("classpath:feature_helpers/schema_get_case_id.feature") response
      And match response.results.status == "received"
      And match response.results.verifiedInsurance.insuranceId == "qm7wys0ag"
      And match response.results.verifiedInsurance.insuranceName == "United Healthcare"
      And match response.results.verifiedInsurance.memberId == "3211233212"
      And match karate.toString(response) !contains "error"

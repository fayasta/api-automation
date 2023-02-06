Feature: PA Request - Requirements

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_requirement_body = read('classpath:collections/pa_automation/jsons/pa_requirement.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_requirement_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set pa_requirement_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post - PA Request - Requirements
        Given path 'api/v2/cases'
        And request pa_requirement_body
        When method Post
        Then assert responseStatus == 201

    @regression @pa_automation @get_pa_requirements
    Scenario: Get - PA Request - Requirements
      * configure retry = { count: 4, interval: 5000 }
      * def postResponse = karate.callSingle('classpath:collections/pa_automation/pa_requirements.feature@post-precondition').response
      * def pa_requirement_case_id = postResponse.caseId
      Given path 'api/v2/cases/' + pa_requirement_case_id
      And retry until response.results.status == "not_required"
      When method Get
      Then assert responseStatus == 200
      * def validate_schema = call read("classpath:feature_helpers/schema_get_case_id.feature") response
      And match response.results.status == "not_required"
      And match response.results.verifiedInsurance.insuranceId == "qm7wys0ag"
      #pending to add sub status
      And match response.results.verifiedInsurance.insuranceName == "United Healthcare"
      And match response.results.verifiedInsurance.memberId == "3211233212"
      And match karate.toString(response) !contains "error"
      And match karate.toString(response) != ""

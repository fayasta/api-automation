Feature: PA Request - Payor Member Prefixes

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_payor_member_prefixes_body = read('classpath:collections/pa_automation/jsons/pa_payor_member_prefixes.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_payor_member_prefixes_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set pa_payor_member_prefixes_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post - PA Request - Payor Member Prefixes
        Given path 'api/v2/cases'
        And request pa_payor_member_prefixes_body
        When method Post
        Then assert responseStatus == 201

    @regression @pa_automation @pa_payor_member_prefixes
    Scenario: Get - PA Request - Payor Member Prefixes
      * configure retry = { count: 4, interval: 5000 }
      * def timeValidatorRegex = read('classpath:helpers/JSValidators/DateValidatorFormat1.js')
      * def timeValidatorRegex2 = read('classpath:helpers/JSValidators/DateValidatorFormat2.js')
      * def timeValidatorRegex3 = read('classpath:helpers/JSValidators/DateValidatorFormat3.js')
      * def postResponse = karate.callSingle('classpath:collections/pa_automation/pa_payor_member_prefixes.feature@post-precondition').response
      * def pa_payor_member_prefixes_case_id = postResponse.caseId
      Given path 'api/v2/cases/' + pa_payor_member_prefixes_case_id
      And retry until response.results.status == "received"
      When method Get
      Then assert responseStatus == 200
      * def validate_schema = call read("classpath:feature_helpers/schema_get_case_id.feature") response
      And match response.results.status == "received"
      And match response.results.verifiedInsurance.insuranceId == "2x7seongi"
      And match response.results.verifiedInsurance.insuranceName == "CareSource of Ohio "
      And match response.results.verifiedInsurance.memberId == "HJK5421232"
      And match karate.toString(response) !contains "error"

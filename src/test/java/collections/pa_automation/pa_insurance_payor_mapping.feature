Feature: PA Request - Insurance Payor Mapping

Background: Base Url and cofigure json body
    Given url base_url
    * def pa_insurance_payor_mapping_body = read('classpath:collections/pa_automation/jsons/pa_insurance_payor_mapping.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_insurance_payor_mapping_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_insurance_payor_mapping_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @regression
    Scenario: Post - PA Request - Insurance Payor Mapping
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        Given path 'api/v2/cases'
        And request pa_insurance_payor_mapping_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201
        * def pa_insurance_payor_mapping_case_id = response.caseId
        * eval sleep(5000)
        Given path 'api/v2/cases/' + pa_insurance_payor_mapping_case_id
        When method Get
        Then assert responseStatus == 200 || responseStatus == 201
    # ToDo add additional Asserts

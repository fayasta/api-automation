Feature: PA Case

Background:
    Given url base_url
    * def pa_case_body = read('classpath:collections/foundation/jsons/pa_case_creation.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set pa_case_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set pa_case_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @regression @foundation @pa_case
    Scenario: Post PA Case
      Given path 'api/v2/cases'
      And request pa_case_body
      When method Post
      Then assert responseStatus == 201

Feature: SeeQer Case


Background: Base Url
    Given url base_url
    * def seeqer_case_body = read('classpath:collections/foundation/jsons/seeqer_case.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_case_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set seeqer_case_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @regression @foundation @seeqer_case
    Scenario: SeeQer Case Creation - Duplicate SeeQer Case/Results
      Given path 'api/v2/cases'
      And request seeqer_case_body
      When method Post
      Then assert responseStatus == 200 || responseStatus == 201


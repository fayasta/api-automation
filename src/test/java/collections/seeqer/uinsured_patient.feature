Feature: SeeQer Uninsured Patient

Background: Base Url
    Given url base_url
    * def seeqer_uninsured_patient_body = read('classpath:collections/seeqer/jsons/uninsured_patient.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_uninsured_patient_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set seeqer_uninsured_patient_body.labOrder.serviceDate = dataGenerator.getRandomDate()

Scenario: Post SeeQer Uninsured Patient
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    Given path 'api/v2/cases'
    And request seeqer_uninsured_patient_body
    When method Post
    Then assert responseStatus == 200 || responseStatus == 201
    * def uninsuredCaseId = respose.caseId
    * eval sleep(2000)
    Given path 'api/v2/cases/' + uninsuredCaseId
    When method Get
    Then assert responseStatus == 200 || responseStatus == 201
# ToDo add additional Asserts

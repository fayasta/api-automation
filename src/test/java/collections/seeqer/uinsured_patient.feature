Feature: SeeQer Uninsured Patient

Background: Base Url
    Given url base_url
    * def seeqer_uninsured_patient_body = read('classpath:collections/seeqer/jsons/uninsured_patient.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_uninsured_patient_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set seeqer_uninsured_patient_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @regression
    Scenario: Post SeeQer Uninsured Patient
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        Given path 'api/v2/cases'
        And request seeqer_uninsured_patient_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201
        * def uninsuredCaseId = response.caseId
        * eval sleep(7000)
        Given path 'api/v2/cases/' + uninsuredCaseId
        When method Get
        Then assert responseStatus == 200 || responseStatus == 201
        And match response.closed == true
        And match response.primaryInsurance.insuranceName == "Uninsured Patient"
        And match response.results.estimatedTotalPatientResponsibility == "$5.00"

Feature: SeeQer Uninsured Patient

Background: Base Url
    Given url base_url
    * def seeqer_uninsured_patient_body = read('classpath:collections/seeqer/jsons/uninsured_patient.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_uninsured_patient_body.labOrder.collectionDate = dataGenerator.getRandomDate()
    * set seeqer_uninsured_patient_body.labOrder.serviceDate = dataGenerator.getRandomDate()

    @post-precondition
    Scenario: Post SeeQer Uninsured Patient
        Given path 'api/v2/cases'
        And request seeqer_uninsured_patient_body
        When method Post
        Then assert responseStatus == 200 || responseStatus == 201
        
    @regression @seeqer @reflex_status_mapping
    Scenario: Get SeeQer Uninsured Patient
        * def sleep = function(pause){java.lang.Thread.sleep(pause)}
        * def postResponse = karate.callSingle('classpath:collections/seeqer/uninsured_patient.feature@post-precondition').response
        * def uninsuredCaseId = postResponse.caseId
        * eval sleep(7000)
        Given path 'api/v2/cases/' + uninsuredCaseId
        When method Get
        Then assert responseStatus == 200 || responseStatus == 201
        And match response.closed == true
        And match response.primaryInsurance.insuranceName == "Uninsured Patient"
        And match response.results.estimatedTotalPatientResponsibility == "$5.00"


Feature: SeeQer Uninsured Patient

Background: Base Url
    Given url base_url
    * def seeqer_uninsured_patient_body = read('classpath:collections/seeqer/jsons/uninsured_patient.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set seeqer_uninsured_patient_body.labOrder.collectionDate = dataGenerator.getRandomDateForCollectionDate()
    * set seeqer_uninsured_patient_body.labOrder.serviceDate = dataGenerator.getRandomDateForService()

    @post-precondition
    Scenario: Post SeeQer Uninsured Patient
        Given path 'api/v2/cases'
        And request seeqer_uninsured_patient_body
        When method Post
        #**************Positive scenarios**************
        # In this section we can add:
        # Status Code verifications, Getting correct values in the response
        Then assert responseStatus == 201
        
    @regression @seeqer @uninsured_patient
    Scenario: Get SeeQer Uninsured Patient
        * configure retry = { count: 4, interval: 5000 }
        * def postResponse = karate.callSingle('classpath:collections/seeqer/uninsured_patient.feature@post-precondition').response
        * def uninsuredCaseId = postResponse.caseId
        Given path 'api/v2/cases/' + uninsuredCaseId
        And retry until response.closed == true
        When method Get
        #**************Positive scenarios**************
        # In this section we can add:
        # Status Code verifications, Getting correct values in the response
        Then assert responseStatus == 200
        * def validate_schema = call read("classpath:feature_helpers/schema_get_case_id.feature") response
        And match response.closed == true
        And match response.primaryInsurance.insuranceName == "Uninsured Patient"
        And match response.results.estimatedTotalPatientResponsibility == "$5.00"


Feature: Validation Feature

@schema
Scenario: validate schema of endpoint: api/v2/cases/{caseId}
    #**************Structure scenarios**************
    # In this section we can add:
    # Schema structure validation
    #Test cases realted to the Json structure(Eg. field 1 = number,string or anything related to it)     
  * def patientSchema = {"patientId": '#string',"firstName":'#string',"middleName":'# string',"lastName":'#string',"gender":'#string',"phoneNumber":'#string',"dob":'#present',"street":'#string',"street2":'#string',"city":'#string',"state":'#string',"zip":'#string'}
  * def providerSchema = ({"externalProviderId":"# string","practiceName":"#string","firstName":"#string","lastName":"#string","npi":"#string","phoneNumber":"#string","faxNumber":"#string"})
  * def clinicSchema = ({"clinicId":"#string","optumClinicName":"##string","clinicName":"#string"})
  * def testSchema = ({"testNames":"#array","optumTestNames":"#array","testIdentifiers":"#array","cptCodes":"#array","testType":"#string"})
  * def primaryInsuranceSchema = ({"insuranceName":"#string","groupId":"#string","planId":"#string","memberId":"#string"})
  * def labOrderSchema = ({"labOrderId":"#string","collectionType":"#string","collectionDate":"#present","serviceDate":"#present","accessionDate":"#string","icd10Codes":"#array"})
  * def verifiedInsuranceSchema = ({"insuranceId":"#string","insuranceName":"#string","memberId":"#string"})
  * def resultsSchema = ({"status":"#string","substatus":"##string","verifiedInsurance":"#(verifiedInsuranceSchema)","authorizedCptCodes":"#array"})
  * def response = __arg
  * match response == 
    """
        {
            "caseId":"#string",
            "caseType":"#string",
            "source":"#string",
            "associatedCases":"#array",
            "closed":"#boolean",
            "labId":"#string",
            "labName":"#string",
            "labClinicId":"#string",
            "notes":"#string",
            "createdAt":"#string",
            "postServiceReview":"#boolean",
            "patient":'#object',
            "otherClinicalInfo":"##string",
            "provider":'#(providerSchema)',
            "clinic":'#(clinicSchema)',
            "test":'#(testSchema)',
            "primaryInsurance":'#(primaryInsuranceSchema)',
            "labOrder":'#(labOrderSchema)',
            "supplementalDocuments":'#array',
            "attachments":"#array",
            "results":'#(resultsSchema)'
        }
    """

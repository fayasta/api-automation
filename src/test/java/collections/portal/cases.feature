Feature: Cases

Background:
    * def caseId = caseId
    Given url base_url

    @regression
    Scenario: Get Case
      Given path 'api/v2/cases/' + caseId
      When method Get
      Then status 200

    @regression
    Scenario: Get Case Attachments  //ToDo - Assertions
        * def caseAttachment = caseAttachment
        Given path 'api/v2/cases/' + caseId +'/attachments/supplemental_docs/' + caseAttachment
        When method Get
        Then status 200
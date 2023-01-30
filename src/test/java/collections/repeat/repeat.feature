Feature: Repeat Features

@ignore 
Scenario Outline: Repeat Features
    * def repeat_scenario = function(i){ return karate.call("classpath:collections/"+<featureFileName>) }
    * def repeat_scenario_result = karate.repeat(repeat_number, repeat_scenario ) 
    Examples:
    |featureFileName|
    |"foundation/Get_cases.feature"|
    |"foundation/PA_case.feature"|
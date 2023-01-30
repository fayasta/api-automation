# api-automation
temporal repo



### Execute command
1. To run the whole suite: ```mvn test``` 
2. To run specific tags: ``` mvn test "-Dkarate.options=--tags @tagName" ```
- ```tagName``` replaces with the tags you want to run
3. To run specfic tags multiple times: ``` mvn test -Dkarate.repeat_number=2 "-Dkarate.options=--tags @repeat-scenarios" ```
- For this consider add the feature file name into ./collections/repeat/repeat.feature Repeat Scenario. 
- ```-Dkarate.repeat_number=2``` refers to how many times the tests would run. By default: 10 times
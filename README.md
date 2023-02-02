# api-automation
temporal repo



### Execute command
1. To run the whole suite: ```mvn test "-Dkarate.options=--tags ~@repeat"``` 
- The ```"-Dkarate.options=--tags ~@repeat" ``` skips ```@repeat``` feature file. 
2. To run specific tags: ``` mvn test "-Dkarate.options=--tags @tagName" ```
3. To run multi tags ``` mvn test "-Dkarate.options=--tags @providers,@cases" ```
- ```tagName``` replaces with the tags you want to run
4. To run specfic tags multiple times: ``` mvn test -Dkarate.repeat_number=2 "-Dkarate.options=--tags @repeat" ```
- For this consider add the feature file name into ./collections/repeat/repeat.feature Repeat Scenario. 
- ```-Dkarate.repeat_number=2``` refers to how many times the tests would run. By default: 1 times
5. To change the environment: ``` mvn test -Dkarate.env=qa "-Dkarate.options=--tags @tagName" ```
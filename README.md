# api-automation
temporal repo



### Execute command
1. To run the whole suite: ```mvn test "-Dkarate.options=--tags @regression" ``` 
2. To run specific tags: ``` mvn test "-Dkarate.options=--tags @tagName" ```
3. To run multi tags ``` mvn test "-Dkarate.options=--tags @providers,@cases" ```
- ```tagName``` replaces with the tags you want to run
5. To change the environment: ``` mvn test -Dkarate.env=qa "-Dkarate.options=--tags @tagName" ```


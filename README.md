# Generate a Spring Boot stub from OpenAPI
We can generate a fully running Spring Boot application from an OpenAPI document.  
It will be only a stub without any business logic.
But it can be quite useful to get a running application with all the endpoints and models.
Use cases are for example:
- To use as a mock server for testing
- To use as a starting point for a new application
- Present to business to show how the API will look like 
- Get feedback on the API from other teams
## 1. Requirements
To generate a Spring Boot stub from OpenAPI (OAS3), you need of course the OpenAPI document, along with with usual Java tools.  
You should have installed and know how to use:
- Java 17
- Maven
## 2. Execute checkfiles.sh
This project uses an OAS3 document from [this little collection]( https://github.com/networkinss/SampleOpenAPICollection[SampleOpenAPICollection).
It is the usual Petstore sample with some adjustments like using only JSON and no XML requests.
OpenAPI Generator is used to generate a Spring Boot stub [OpenAPI Generator](https://openapi-generator.tech/).  
The script checkfiles.sh will check if the OAS3 document and the OpenAPI Generator is there, and download them if not.  

For adjustements of the OAS3 document, you can use the Swagger Editor: https://editor.swagger.io/.    
After the execution of the checkfiles.sh script, you should have a **openapi.yaml**  
and the **openapi-generator-cli-6.2.1.jar** file.  
```
./checkfiles.sh
```

## 3. Generate the Spring Boot stub
Now once you have the generator and the OAS3 document, you can use the script **generate.sh**
to generate the Spring Boot stub.  
It does several steps, and will also build the jar with maven. The lines for running the application is commented.  

There is a Bash script for Linux and also a PowerShell script for Windows.
```
./generate.sh
```

## Adjust parameters to your needs
There are a lot of parameters which can be used. I used some of them in the script, although they are using a default value.
Just to make aware of the options.  
Checkout the [OpenAPI Generator for Spring](https://openapi-generator.tech/docs/generators/spring/) site for more information 
about the parameters.  
Like you can add the annotation "@Data" with "additionalModelTypeAnnotations" to the model classes in additional-properties.  
Additional properties can be added in the generate.sh script in the variable ADD.

## Start
To start the application, run
```
mvn spring-boot:run
```
It will be accessible at http://localhost:8080. It should re-direct to http://localhost:8080/swagger-ui/index.html 
for the generated OAS3 document. 
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
To generate a Spring Boot stub from OpenAPI (OAS3), you need of course the OpenAPI document, along with the usual Java tools.  
You should have installed and know how to use:
- Java 17
- Maven
## 2. Execute checkfiles.sh
This project uses an OAS3 document from [this little collection](https://github.com/networkinss/SampleOpenAPICollection).
It is the usual Petstore sample with some adjustments like using only JSON and no XML requests.
OpenAPI Generator is used to generate a Spring Boot stub [OpenAPI Generator](https://openapi-generator.tech/).  
The script checkfiles.sh will check if the OAS3 document and the OpenAPI Generator is there, and download them if not.  

For adjustments of the OAS3 document, you can use the Swagger Editor: https://editor.swagger.io/.    
After the execution of the checkfiles.sh script, you should have a **openapi.yaml**  
and the **openapi-generator-cli-7.27.0.jar** file.  
The scripts are located in the folder `vorbereitung/bin` and must be run from there:
```
cd vorbereitung/bin
```
```
./checkfiles.sh
```

## 3. Generate the Spring Boot stub
Now once you have the generator and the OAS3 document, you can use the script **generate.sh**
to generate the Spring Boot stub.  
It does several steps, and will also build the jar with maven. The lines for running the application are commented out.  

There is a Bash script for Linux and also a PowerShell script for Windows.
Run it from the folder `vorbereitung/bin` as well:
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
To start the application, run the following command in the generated project folder `vorbereitung/bin/petstore_spring_apifirst`,
or in the folder `app` for the adjusted version in this repository:
```
mvn spring-boot:run
```
It will be accessible at http://localhost:8080. It should re-direct to http://localhost:8080/swagger-ui/index.html 
for the generated OAS3 document. 

Note that the stub endpoints respond with HTTP status **501 Not Implemented**, even though they return the example from the OAS3 document as body (if the request has the header `Accept: application/json`).
This is intended by OpenAPI Generator to show that the operation is not implemented yet; with the option `returnSuccessCode=true` the stub returns the success status code from the OAS3 document instead, which is more convenient for a mock server.

## Versions
Status as of 2026-11-16:
- The application in the folder `app` uses Spring Boot 4.1.2 (Spring Framework 7, Jackson 3) with springdoc 3.2.0 and OpenAPI Generator 7.27.0.
- The scripts in `vorbereitung/bin` use OpenAPI Generator 7.27.0 with the options `useSpringBoot4=true` and `useJackson3=true`.
  The generated project gets its versions from the generator template: Spring Boot 4.0.1 and springdoc 2.6.0.
  It builds and runs with these versions, but for Spring Boot 4 springdoc 3.x is the matching version, so it is recommended to raise both in the generated pom.xml
  (as done in `app`).

The last Spring Boot 3 version of this project (Spring Boot 3.5.16, springdoc 2.10.0, OpenAPI Generator 7.2.0) is the commit `c8f42bf`.
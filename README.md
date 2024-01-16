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
This project will use an OAS3 document from [this little collection]( https://github.com/networkinss/SampleOpenAPICollection[SampleOpenAPICollection).
And will use OpenAPI Generator to generate a Spring Boot stub [OpenAPI Generator](https://openapi-generator.tech/).  
The script checkfiles.sh will check if the OAS3 document and the OpenAPI Generator is there, and download them if not.  
The used generator version is 6.2.1. You can change to a newer version when one is available.

In this tutorial, we will use this OAS3 document: https://raw.githubusercontent.com/networkinss/SampleOpenAPICollection/master/petstore/petstore_oas3_inss.yaml
That document is a common petstore sample, cleaned up a bit.  
If you want to see the OAS3 document in a nice editor, you can use the Swagger Editor: https://editor.swagger.io/.    
After the execution of the checkfiles.sh script, you should have a file **openapi.yaml** and in the bin folder the **openapi-generator-cli-6.2.1.jar** file.  
```
./checkfiles.sh
```

## 3. Generate the Spring Boot stub
Now once you have the generator and the OAS3 document, you can use the script **generate.sh** to generate the Spring Boot stub.  
It does several steps, and will also build the jar with maven and run the application.  
How it is in IT, it runs on my machine. But if you missed the requirements or face other problems,   
you can do the steps manually to debug it.
There is a Bash script for Linux and also a PowerShell script for Windows.
```
./generate.sh
```

## Adjust parameters to your needs
There are a lot of parameters which can be used. I used some of them in the script, although they are using a default value.
Just to make aware of the possibilities.  
Checkout the [OpenAPI Generator for Spring](https://openapi-generator.tech/docs/generators/spring/) site for more information 
about the parameters.  
Like you can add the annotation "@Data" with "additionalModelTypeAnnotations" to the model classes in additional-properties.  
Additional properties can be added in the generate.sh script in the variable ADD.
#!/bin/bash
if [ ! -f openapi-generator-cli-7.2.0.jar ]; then
  curl https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/7.2.0/openapi-generator-cli-7.2.0.jar --output ./openapi-generator-cli-7.2.0.jar
else
  echo "Generator ok."
fi

if [ ! -f openapi.yaml ]; then
  curl https://raw.githubusercontent.com/networkinss/SampleOpenAPICollection/master/petstore/petstore_oas3_inss.yaml --output openapi.yaml
else
  echo "OpenAPI file ok."
fi
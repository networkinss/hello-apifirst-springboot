#!/bin/bash
if [ ! -f openapi-generator-cli-7.2.0.jar ]; then
  curl -fL https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/7.2.0/openapi-generator-cli-7.2.0.jar --output ./openapi-generator-cli-7.2.0.jar || { echo "Download of the generator failed."; rm -f ./openapi-generator-cli-7.2.0.jar; exit 1; }
else
  echo "Generator ok."
fi

if [ ! -f openapi.yaml ]; then
  curl -fL https://raw.githubusercontent.com/networkinss/SampleOpenAPICollection/master/petstore/petstore_oas3_inss.yaml --output openapi.yaml || { echo "Download of the OpenAPI file failed."; rm -f openapi.yaml; exit 1; }
else
  echo "OpenAPI file ok."
fi
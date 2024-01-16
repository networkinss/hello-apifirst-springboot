$generatorExists = Test-Path -Path "openapi-generator-cli-7.2.0.jar"
New-Item -Path bin -ItemType Directory -ErrorAction Ignore
if (!$generatorExists) {
    Invoke-WebRequest -Uri "https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/7.2.0/openapi-generator-cli-7.2.0.jar" -OutFile "openapi-generator-cli-7.2.0.jar"
}else{
    Write-Host "Generator file ok."
}


$openapiExists = Test-Path -Path "openapi.yaml"
if (!$openapiExists) {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/networkinss/SampleOpenAPICollection/master/petstore/petstore_oas3_inss.yaml" -OutFile "openapi.yaml"
}else{
    Write-Host "OpenAPI file ok."
}

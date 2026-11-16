
# Used also for artifactId and therefore must not contain uppercase or special characters.
$APP = "petstore_spring_apifirst"
$BASE = "com.example"
$VERSION = "0.0.1"
$JAR = "$APP-$VERSION.jar"
$YAML = "openapi.yaml"
$PACKAGE = "basePackage=$BASE,invokerPackage=$BASE,apiPackage=$BASE.api,configPackage=$BASE.config,modelPackage=$BASE.model"
$ADD = "--additional-properties=useSpringBoot4=true,useJackson3=true,apiFirst=true,artifactId=$APP,groupId=$BASE,$PACKAGE,artifactVersion=$VERSION,returnSuccessCode=false,skipDefaultInterface=false,sourceFolder=src/main/java,title=petstore,artifactDescription=PetstoreAPIFirstExample"
Write-Host "validate"
java -jar openapi-generator-cli-7.27.0.jar validate -i "./$YAML"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error in: java -jar openapi-generator-cli-7.27.0.jar validate -i ./$YAML"
    exit 1
}
Write-Host "rm -rf ./$APP/*"
Write-Host "and start generate..."
Start-Sleep -s 3
Remove-Item -Recurse "./$APP/*"  -ErrorAction Ignore
java -jar openapi-generator-cli-7.27.0.jar generate -i "./$YAML" -g spring -o "./$APP/" $ADD
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error in: java -jar openapi-generator-cli-7.27.0.jar generate -i ./$YAML -g spring -o ./$APP/ $ADD"
    exit 1
}
Write-Host ""
Write-Host "Now create jar with 'cd $APP'"
Write-Host "'mvn clean package'"
Start-Sleep -s 3
Push-Location "$APP/"
Write-Host ""
mvn clean package
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error in: mvn clean package"
    Pop-Location
    exit 1
}
Write-Host "mv target/$JAR .."
Move-Item "target/$JAR" ".." -Force
if (-not $?) {
    Write-Host "Error moving to target folder."
    Pop-Location
    exit 1
}
Pop-Location

# Comment this in if you directly want to start the application.
#Write-Host ""
#Write-Host "Going to start $APP"
#Write-Host "java -jar -Dserver.port=8080 $JAR"
#Start-Sleep -s 3
#Write-Host ""
#Write-Host "Starting the application with: java -jar -Dserver.port=8080 $JAR"
#Write-Host "After start you can open the application with: http://localhost:8080/"
#Write-Host "and access the swagger-ui with: http://localhost:8080/swagger-ui.html"
#Write-Host "Stop the application with: Ctrl-C"
#java -jar $JAR
#if ($LASTEXITCODE -ne 0) {
#    Write-Host "Error starting $JAR."
#    exit 1
#}

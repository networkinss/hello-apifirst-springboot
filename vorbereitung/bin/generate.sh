#!/bin/bash
# Used also for artifactId and therefore must not contain uppercase or special characters.
APP=petstore_spring_apifirst
BASE=com.example
VERSION=0.0.1
JAR=$APP-$VERSION.jar
YAML=openapi.yaml
PACKAGE=basePackage=$BASE,invokerPackage=$BASE,apiPackage=$BASE.api,configPackage=$BASE.config,modelPackage=$BASE.model
ADD=--additional-properties=useSpringBoot3=true,apiFirst=true,skipDefaultInterface=false,returnSuccessCode=false,artifactId=$APP,groupId=$BASE,$PACKAGE,artifactVersion=$VERSION,sourceFolder=src/main/java,title=petstore,artifactDescription=PetstoreAPIFirstExample
echo validate
java -jar openapi-generator-cli-7.2.0.jar validate -i ./$YAML
echo rm -rf ./$APP/*
echo and start generate...
sleep 3
rm -rf ./$APP/*
java -jar openapi-generator-cli-7.2.0.jar generate -i ./$YAML -g spring -o ./$APP/ $ADD
if [ ! $? -eq 0 ]; then
  echo "Error in: java -jar bin/openapi-generator-cli-7.2.0.jar -i ./$YAML -g spring -o ./output/$APP/ $ADD"
  exit 1
fi
echo
echo Now create jar with cd $APP/target
echo 'mvn clean package'
sleep 3
pushd $APP/ || exit 1
echo
mvn clean package
echo mv target/$JAR ..
mv target/$JAR ..
if [ ! $? -eq 0 ]; then
  echo "Error moving to target folder."
  exit 1
fi
popd || exit 1
# Comment this in if you directly want to start the application.
#echo
#echo Going to start $APP
#echo java -jar -Dserver.port=8080 $JAR
#sleep 3
#echo
#echo "Starting the application with: java -jar -Dserver.port=8080 $JAR"
#echo "After start you can open the application with: http://localhost:8080/"
#echo "and access the swagger-ui with: http://localhost:8080/swagger-ui.html"
#echo "Stop the application with: Ctrl-C"
#java -jar -Dserver.port=8080 $JAR
#if [ ! $? -eq 0 ]; then
#  echo "Error starting $JAR."
#  exit 1
#fi
#

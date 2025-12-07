@echo off
rem Run WordProducer class using the fat JAR
rem Usage: run_producer.bat [topic]

setlocal
set JAR=target\kafka-wordcount-app-jar-with-dependencies.jar
if not exist "%JAR%" (
  rem fallback to hadoop_project location
  set JAR=hadoop_project\kafka\kafka-wordcount-app-jar-with-dependencies.jar
)

if not exist "%JAR%" (
  echo Fat JAR not found. Build with: mvn clean package
  pause
  exit /b 1
)

rem default topic
if "%~1"=="" (
  set TOPIC=input-topic
) else (
  set TOPIC=%~1
)

echo Running WordProducer with topic "%TOPIC%" using "%JAR%"
java -cp "%JAR%" edu.supmti.kafka.WordProducer %TOPIC%

endlocal

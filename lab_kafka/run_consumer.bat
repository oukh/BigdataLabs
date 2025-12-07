@echo off
rem Run WordCountConsumer class using the fat JAR
rem Usage: run_consumer.bat [topic]

setlocal
set JAR=target\kafka-wordcount-app-jar-with-dependencies.jar
if not exist "%JAR%" (
  set JAR=hadoop_project\kafka\kafka-wordcount-app-jar-with-dependencies.jar
)

if not exist "%JAR%" (
  echo Fat JAR not found. Build with: mvn clean package
  pause
  exit /b 1
)

if "%~1"=="" (
  set TOPIC=output-topic
) else (
  set TOPIC=%~1
)

echo Running WordCountConsumer with topic "%TOPIC%" using "%JAR%"
java -cp "%JAR%" edu.supmti.kafka.WordCountConsumer %TOPIC%

endlocal

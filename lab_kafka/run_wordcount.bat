@echo off
rem Run WordCount Streams application from the fat JAR
rem Usage: run_wordcount.bat [input-topic] [output-topic]

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
  set INPUT=input-topic
) else (
  set INPUT=%~1
)

if "%~2"=="" (
  set OUTPUT=output-topic
) else (
  set OUTPUT=%~2
)

echo Running WordCountApp with input "%INPUT%" and output "%OUTPUT%" using "%JAR%"
java -jar "%JAR%" %INPUT% %OUTPUT%

endlocal

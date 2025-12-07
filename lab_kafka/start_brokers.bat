@echo off
rem Start three Kafka brokers (default config + server-one + server-two)
set KAFKA_BIN=C:\kafka\bin\windows
if not exist "%KAFKA_BIN%\kafka-server-start.bat" (
  echo Kafka scripts not found at %KAFKA_BIN%. Please install Kafka or set KAFKA_BIN accordingly.
  pause
  exit /b 1
)
rem Start default broker (if you have config in KAFKA_HOME\config\server.properties)
start "broker-default" cmd /k "%KAFKA_BIN%\kafka-server-start.bat C:\kafka\config\server.properties"
rem Start broker one using our config
start "broker-one" cmd /k "%KAFKA_BIN%\kafka-server-start.bat C:\Users\oussa\BigdataLabs\lab_kafka\config\server-one.properties"
rem Start broker two using our config
start "broker-two" cmd /k "%KAFKA_BIN%\kafka-server-start.bat C:\Users\oussa\BigdataLabs\lab_kafka\config\server-two.properties"

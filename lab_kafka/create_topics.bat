@echo off
rem Create input and output topics (assumes Kafka at C:\kafka)
set KAFKA_BIN=C:\kafka\bin\windows
if not exist "%KAFKA_BIN%\kafka-topics.bat" (
  echo Kafka scripts not found at %KAFKA_BIN%. Please set KAFKA_BIN to your Kafka installation.
  pause
  exit /b 1
)
"%KAFKA_BIN%\kafka-topics.bat" --create --topic input-topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
"%KAFKA_BIN%\kafka-topics.bat" --create --topic output-topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
"%KAFKA_BIN%\kafka-topics.bat" --list --bootstrap-server localhost:9092
pause

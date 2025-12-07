@echo off
REM Apache Kafka Lab - Quick Commands Reference

echo.
echo ============================================================
echo Apache Kafka Lab - Command Reference
echo ============================================================
echo.

echo 1. CREATE TOPICS
echo kafka-topics.sh --create --bootstrap-server localhost:9092 --topic Hello-Kafka --partitions 1 --replication-factor 1
echo kafka-topics.sh --create --bootstrap-server localhost:9092 --topic WordCount-Topic --partitions 1 --replication-factor 1
echo kafka-topics.sh --create --bootstrap-server localhost:9092 --topic input-topic --partitions 1 --replication-factor 1
echo kafka-topics.sh --create --bootstrap-server localhost:9092 --topic output-topic --partitions 1 --replication-factor 1
echo.

echo 2. LIST TOPICS
echo kafka-topics.sh --list --bootstrap-server localhost:9092
echo.

echo 3. DESCRIBE TOPIC
echo kafka-topics.sh --describe --topic Hello-Kafka --bootstrap-server localhost:9092
echo.

echo 4. BUILD PROJECT
echo mvn clean package -DskipTests
echo.

echo 5. RUN EventProducer
echo java -cp target/kafka-app.jar edu.supmti.kafka.EventProducer Hello-Kafka
echo.

echo 6. RUN EventConsumer
echo java -cp target/kafka-app.jar edu.supmti.kafka.EventConsumer Hello-Kafka
echo.

echo 7. RUN WordCountApp (Terminal 1)
echo java -cp target/kafka-app.jar edu.supmti.kafka.WordCountApp input-topic output-topic
echo.

echo 8. SEND MESSAGES TO INPUT-TOPIC (Terminal 2)
echo kafka-console-producer.sh --bootstrap-server localhost:9092 --topic input-topic
echo.

echo 9. READ RESULTS FROM OUTPUT-TOPIC (Terminal 3)
echo kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic output-topic --from-beginning --property print.key=true
echo.

echo 10. RUN WordProducer (Terminal 1)
echo java -cp target/kafka-app.jar edu.supmti.kafka.WordProducer WordCount-Topic
echo.

echo 11. RUN WordCountConsumer (Terminal 2)
echo java -cp target/kafka-app.jar edu.supmti.kafka.WordCountConsumer WordCount-Topic
echo.

echo 12. CONSOLE PRODUCER
echo kafka-console-producer.sh --bootstrap-server localhost:9092 --topic Hello-Kafka
echo.

echo 13. CONSOLE CONSUMER
echo kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic Hello-Kafka --from-beginning
echo.

echo ============================================================
echo Note: Make sure Kafka and Zookeeper are running!
echo ============================================================

# Apache Kafka Lab - Implementation Guide

## Project Overview
Your Kafka project has been successfully set up with all required classes for the lab assignments.

## Created Classes

### 1. **EventProducer** (`EventProducer.java`)
- Reads a topic name as command-line argument
- Produces 10 messages to the specified Kafka topic
- Each message has a key-value pair (integer: integer)
- Configuration: `localhost:9092` bootstrap server

**Usage:**
```bash
java -jar kafka-app.jar HelloWorld Hello-Kafka
```

### 2. **EventConsumer** (`EventConsumer.java`)
- Reads messages from a specified Kafka topic
- Displays: offset, key, and value for each message
- Uses consumer group "test"
- Continuous listener mode

**Usage:**
```bash
java -jar kafka-app.jar Hello-Kafka
```

### 3. **WordCountApp** (`WordCountApp.java`)
- Kafka Streams application for real-time word counting
- Reads from input topic (argument 1)
- Writes word frequency counts to output topic (argument 2)
- Uses state store for word count tracking

**Usage:**
```bash
java -jar kafka-app.jar input-topic output-topic
```

**Required Topics:**
```bash
kafka-topics.sh --create --bootstrap-server localhost:9092 --topic input-topic --partitions 1 --replication-factor 1
kafka-topics.sh --create --bootstrap-server localhost:9092 --topic output-topic --partitions 1 --replication-factor 1
```

### 4. **WordProducer** (`WordProducer.java`)
- Interactive word input from keyboard
- Sends each word to Kafka topic
- Supports multi-broker Kafka cluster
- Bootstrap servers: `localhost:9092,localhost:9093,localhost:9094`

**Usage:**
```bash
java -jar kafka-app.jar WordCount-Topic
```

### 5. **WordCountConsumer** (`WordCountConsumer.java`)
- Reads words from Kafka topic
- Maintains real-time word frequency map
- Displays updated counts periodically
- Supports multi-broker Kafka cluster

**Usage:**
```bash
java -jar kafka-app.jar WordCount-Topic
```

## Maven Configuration

### Dependencies Included:
- `kafka-clients:3.5.1` - Kafka producer/consumer API
- `kafka-streams:3.5.1` - Stream processing library
- `slf4j-api:1.7.36` - Logging API
- `slf4j-simple:1.7.36` - Logging implementation

### Build Configuration:
- Java Compiler: 1.8 (Java 8)
- Assembly plugin for creating fat JAR with all dependencies
- Main JAR file: `kafka-app.jar`

## Step-by-Step Lab Instructions

### Step 1: Create Topics
```bash
# Create Hello-Kafka topic
kafka-topics.sh --create --bootstrap-server localhost:9092 \
  --replication-factor 1 --partitions 1 --topic Hello-Kafka

# Create WordCount-Topic
kafka-topics.sh --create --bootstrap-server localhost:9092 \
  --replication-factor 1 --partitions 1 --topic WordCount-Topic

# Create input and output topics for WordCountApp
kafka-topics.sh --create --bootstrap-server localhost:9092 \
  --topic input-topic --partitions 1 --replication-factor 1

kafka-topics.sh --create --bootstrap-server localhost:9092 \
  --topic output-topic --partitions 1 --replication-factor 1

# Verify topics
kafka-topics.sh --list --bootstrap-server localhost:9092
```

### Step 2: Build the Project
```bash
mvn clean package -DskipTests
```

The JAR file will be created at: `target/kafka-app.jar`

### Step 3: Run EventProducer
Terminal 1:
```bash
java -cp target/kafka-app.jar edu.supmti.kafka.EventProducer Hello-Kafka
```

### Step 4: Run EventConsumer
Terminal 2:
```bash
java -cp target/kafka-app.jar edu.supmti.kafka.EventConsumer Hello-Kafka
```

### Step 5: Run WordCountApp (Kafka Streams)
Terminal 1:
```bash
java -cp target/kafka-app.jar edu.supmti.kafka.WordCountApp input-topic output-topic
```

Terminal 2 (Send messages):
```bash
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic input-topic
# Type sentences: "hello world kafka", "kafka is awesome", etc.
```

Terminal 3 (Read results):
```bash
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic output-topic \
  --from-beginning --property print.key=true
```

### Step 6: Multi-Broker Configuration (Optional)

Create additional broker configurations:
```bash
# server-one.properties
broker.id=1
listeners=PLAINTEXT://localhost:9093
log.dirs=/tmp/kafka-logs-1

# server-two.properties
broker.id=2
listeners=PLAINTEXT://localhost:9094
log.dirs=/tmp/kafka-logs-2
```

Start additional brokers:
```bash
$KAFKA_HOME/bin/kafka-server-start.sh config/server-one.properties
$KAFKA_HOME/bin/kafka-server-start.sh config/server-two.properties
```

### Step 7: Run WordProducer and WordCountConsumer
Terminal 1:
```bash
java -cp target/kafka-app.jar edu.supmti.kafka.WordProducer WordCount-Topic
# Type: "hello world", "kafka rocks", etc.
```

Terminal 2:
```bash
java -cp target/kafka-app.jar edu.supmti.kafka.WordCountConsumer WordCount-Topic
```

## Directory Structure
```
lab_kafka/
├── pom.xml
├── src/
│   └── main/
│       └── java/
│           └── edu/
│               └── supmti/
│                   └── kafka/
│                       ├── EventProducer.java
│                       ├── EventConsumer.java
│                       ├── WordCountApp.java
│                       ├── WordProducer.java
│                       ├── WordCountConsumer.java
│                       └── Main.java
└── target/
    └── kafka-app.jar
```

## Key Configuration Points

### Bootstrap Servers
- Single broker: `localhost:9092`
- Multi-broker: `localhost:9092,localhost:9093,localhost:9094`

### Consumer Groups
- EventConsumer: `test`
- WordCountConsumer: `word-count-group`

### Serialization
- Key: `StringSerializer` / `StringDeserializer`
- Value: `StringSerializer` / `StringDeserializer`

## Troubleshooting

1. **Port Already in Use**: Change broker ports in configuration
2. **Topic Not Found**: Create topic before running consumers/producers
3. **Classpath Issues**: Use `-cp target/kafka-app.jar` with class name
4. **No Messages**: Verify bootstrap servers are correct and Kafka is running

## Next Steps for Kafka UI

To add Kafka UI for visual monitoring, add this to your `docker-compose.yml`:

```yaml
kafka-ui:
  image: provectuslabs/kafka-ui:latest
  container_name: kafka-ui
  hostname: kafka-ui
  ports:
    - 8081:8080
  environment:
    - KAFKA_CLUSTERS_0_NAME=local
    - KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=localhost:9092
    - KAFKA_CLUSTERS_0_ZOOKEEPER=localhost:2181
```

Access at: `http://localhost:8081`

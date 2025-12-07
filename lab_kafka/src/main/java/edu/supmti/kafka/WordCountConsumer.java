package edu.supmti.kafka;

import java.util.Properties;
import java.util.Arrays;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.ConsumerRecord;

public class WordCountConsumer {

    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Usage: java WordCountConsumer <topic-name>");
            return;
        }

        String topicName = args[0];

        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9092,localhost:9093,localhost:9094");
        props.put("group.id", "word-count-group");
        props.put("enable.auto.commit", "true");
        props.put("auto.commit.interval.ms", "1000");
        props.put("session.timeout.ms", "30000");
        props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");

        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);
        consumer.subscribe(Arrays.asList(topicName));

        System.out.println("Listening to topic: " + topicName);
        System.out.println("Real-time word frequency:\n");

        Map<String, Integer> wordCounts = new HashMap<>();

        while (true) {
            ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(100));
            for (ConsumerRecord<String, String> record : records) {
                String word = record.key();
                wordCounts.put(word, wordCounts.getOrDefault(word, 0) + 1);
            }

            // Display word counts
            if (!wordCounts.isEmpty()) {
                System.out.println("\n=== Word Frequency Count ===");
                wordCounts.forEach((word, count)
                        -> System.out.println(word + ": " + count)
                );
            }
        }
    }
}

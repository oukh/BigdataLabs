package edu.supmti.kafka;

import java.util.Properties;
import java.util.Scanner;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

public class WordProducer {

    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Usage: java WordProducer <topic-name>");
            return;
        }

        String topicName = args[0];

        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9092,localhost:9093,localhost:9094");
        props.put("acks", "all");
        props.put("retries", 0);
        props.put("batch.size", 16384);
        props.put("buffer.memory", 33554432);
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");

        KafkaProducer<String, String> producer = new KafkaProducer<>(props);

        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter words to send to Kafka (type 'exit' to quit):");

        int messageCount = 0;
        while (true) {
            String input = scanner.nextLine();
            if ("exit".equalsIgnoreCase(input)) {
                break;
            }

            // Split the input into words
            String[] words = input.split("\\s+");
            for (String word : words) {
                if (!word.isEmpty()) {
                    ProducerRecord<String, String> record
                            = new ProducerRecord<>(topicName, word, word);
                    producer.send(record);
                    messageCount++;
                    System.out.println("Sent: " + word);
                }
            }
        }

        System.out.println("Total messages sent: " + messageCount);
        producer.close();
        scanner.close();
    }
}

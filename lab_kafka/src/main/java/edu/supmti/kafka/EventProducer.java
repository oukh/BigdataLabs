package edu.supmti.kafka;

import java.util.Properties;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

public class EventProducer {

    public static void main(String[] args) throws Exception {
        // Verify that the topic is provided as an argument
        if (args.length == 0) {
            System.out.println("Entrer le nom du topic");
            return;
        }

        String topicName = args[0].toString(); // read the topicName provided as parameter

        // Access the producer configurations
        Properties props = new Properties();

        props.put("bootstrap.servers", "localhost:9092"); // specify the kafka server
        // Define an acknowledgment for the producer requests
        props.put("acks", "all");
        // If the request fails, the producer can retry automatically
        props.put("retries", 0);
        // Specify the buffer size in the config
        props.put("batch.size", 16384);
        // Control the total space of available memory to the producer for buffering
        props.put("buffer.memory", 33554432);
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");

        Producer<String, String> producer = new KafkaProducer<String, String>(props);

        for (int i = 0; i < 10; i++) {
            producer.send(new ProducerRecord<String, String>(topicName,
                    Integer.toString(i), Integer.toString(i)));
        }

        System.out.println("Message envoye avec succes");
        producer.close();
    }
}

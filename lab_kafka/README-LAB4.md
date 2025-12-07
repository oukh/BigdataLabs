# Lab 4 — Apache Kafka (Big Data Engineering)

Ce dépôt contient le code et les scripts pour le TP Kafka (WordCount, Producer/Consumer, Connect).

Prérequis
- Java 8+ (JDK)
- Maven
- Docker (optionnel pour kafka-ui)
- Apache Kafka installé et extrait sur la machine (ex: `C:\kafka`) ou disponible dans les conteneurs du cluster.

Fichiers importants
- `src/main/java/edu/supmti/kafka/` : classes Java (EventProducer, EventConsumer, WordProducer, WordCountConsumer, WordCountApp)
- `pom.xml` : build Maven — crée trois fat JARs lors de `mvn package`:
  - `target\kafka-wordcount-app-jar-with-dependencies.jar` (WordCount Streams app)
  - `target\kafka-producer-app-jar-with-dependencies.jar` (EventProducer)
  - `target\kafka-consumer-app-jar-with-dependencies.jar` (EventConsumer)
- `config/server-one.properties`, `config/server-two.properties` : configurations pour brokers supplémentaires (ports 9093 et 9094)
- `docker-compose.yml` : service `kafka-ui` (port 8081)
- Batch scripts:
  - `create_topics.bat` : crée `input-topic` et `output-topic`
  - `start_brokers.bat` : démarre les brokers (suppose Kafka installé sous `C:\kafka`)
  - `run_wordcount.bat` : lance l'application WordCountStreams
  - `run_producer.bat` : lance `WordProducer` (interactive)
  - `run_consumer.bat` : lance `WordCountConsumer`

Étapes rapides (cmd.exe)
1) Construire les JARs
```cmd
cd C:\Users\oussa\BigdataLabs\lab_kafka
mvn clean package
```

2) Copier le JAR vers le dossier partagé Hadoop (optionnel)
```cmd
copy target\kafka-wordcount-app-jar-with-dependencies.jar C:\shared_volume\kafka\
```

3) Démarrer Zookeeper et Kafka (exemples locaux)
```cmd
cd C:\kafka\bin\windows
start cmd /k "zookeeper-server-start.bat ..\..\config\zookeeper.properties"
start cmd /k "kafka-server-start.bat ..\..\config\server.properties"
start cmd /k "kafka-server-start.bat C:\Users\oussa\BigdataLabs\lab_kafka\config\server-one.properties"
start cmd /k "kafka-server-start.bat C:\Users\oussa\BigdataLabs\lab_kafka\config\server-two.properties"
```

4) Créer topics
```cmd
cd C:\Users\oussa\BigdataLabs\lab_kafka
create_topics.bat
```

5) Lancer WordCountStreams
```cmd
cd C:\Users\oussa\BigdataLabs\lab_kafka
run_wordcount.bat input-topic output-topic
```

6) Produire et consommer
```cmd
C:\kafka\bin\windows\kafka-console-producer.bat --topic input-topic --bootstrap-server localhost:9092
C:\kafka\bin\windows\kafka-console-consumer.bat --topic output-topic --from-beginning --bootstrap-server localhost:9092 --property print.key=true
```

7) Lancer l'application interactive (producer/consumer Java)
```cmd
run_producer.bat WordCount-Topic
run_consumer.bat WordCount-Topic
```

8) Démarrer kafka-ui (Docker)
```cmd
cd C:\Users\oussa\BigdataLabs\lab_kafka
docker-compose up -d
# then open http://localhost:8081
```

Notes
- Si vous utilisez le cluster Hadoop décrit dans le TP précédent, adaptez les chemins et exécutez les commandes dans le conteneur `hadoop-master`.
- Le téléchargement/installation de Kafka n'a pas été automatisé avec succès depuis cet environnement ; effectuez l'extraction manuelle si nécessaire.

---
Aidez‑moi : voulez‑vous que j'essaie de rebuild (`mvn package`) ici pour produire les trois jars maintenant ?

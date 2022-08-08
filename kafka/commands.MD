

./kafka-topics.sh --bootstrap-server devops-cluster-kafka-brokers:9092 --list
./kafka-topics.sh --bootstrap-server devops-cluster-kafka-brokers:9092 --topic test --replication-factor 3 --partitions 3 --create
./kafka-topics.sh --bootstrap-server devops-cluster-kafka-brokers:9092 --topic test --describe
./kafka-console-producer.sh --bootstrap-server devops-cluster-kafka-brokers:9092 --topic test
./kafka-console-consumer.sh --bootstrap-server devops-cluster-kafka-brokers:9092 --topic test --from-beginning
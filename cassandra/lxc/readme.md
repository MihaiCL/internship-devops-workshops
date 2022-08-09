Install 3 nodes with Cassandra

Steps
1. Create LXC containers
2. Check if each container can connect to other containers
3. Install Cassandra on each container
4. Setup each node with the proper configurations
5. Start one node at a time

```bash
01-setup-nodes.sh
```

Resources:
* https://cassandra.apache.org/doc/latest/cassandra/getting_started/installing.html#installing-the-debian-packages
* https://cassandra.apache.org/doc/latest/cassandra/getting_started/configuring.html
* https://cassandra.apache.org/doc/latest/cassandra/configuration/cass_yaml_file.html
* https://docs.datastax.com/en/cassandra-oss/3.0/cassandra/configuration/secureFireWall.html
* https://docs.datastax.com/en/cassandra-oss/3.0/cassandra/initialize/initSingleDS.html
* https://cassandra.apache.org/doc/trunk/cassandra/architecture/storage_engine.html
* https://docs.datastax.com/en/dse/6.8/dse-admin/datastax_enterprise/production/seedNodesForSingleDC.html
* https://docs.datastax.com/en/cassandra-oss/3.0/cassandra/initialize/initSingleDS.html
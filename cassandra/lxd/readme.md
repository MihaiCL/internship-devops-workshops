Install 3 nodes with Cassandra

Steps
1. Create LXC containers
2. Check if each container can connect to other containers
4. Install Cassandra on each container
5. Setup each node with the proper configurations

```bash
01-setup-nodes.sh
```

Install Cassandra 

```bash
echo "deb http://www.apache.org/dist/cassandra/debian 40x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
apt update
apt install cassandra
```

Resources:
* https://cassandra.apache.org/doc/latest/cassandra/getting_started/installing.html#installing-the-debian-packages
* https://cassandra.apache.org/doc/latest/cassandra/getting_started/configuring.html
* https://docs.datastax.com/en/cassandra-oss/3.0/cassandra/configuration/secureFireWall.html
* https://docs.datastax.com/en/cassandra-oss/3.0/cassandra/initialize/initSingleDS.html
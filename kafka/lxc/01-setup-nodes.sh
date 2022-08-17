#!/bin/bash
for i in 1 2 3;
do
lxc launch images:ubuntu/20.04 node$i
lxc config set node$i limits.memory 2GB
lxc config set node$i limits.cpu.allowance 20%
lxc config show node$i
lxc exec node$i -- apt install ssh -y
lxc file push --uid 0 --gid 0 files/sshd_config node$i/etc/ssh/sshd_config
lxc exec node$i systemctl restart ssh
lxc exec node$i -- apt install wget -y
lxc exec node$i -- apt install -y openjdk-8-jre
lxc file push --create-dirs --uid 0 --gid 0 ~/.ssh/id_rsa.pub node$i/root/.ssh/authorized_keys
done

lxc list -c 4,n -f csv | sed 's/ (eth0),/ /g' > hosts

for i in 1 2 3;
do
lxc file push --uid 0 --gid 0 ./hosts node$i/etc/hosts
done

#for i in 1 2 3;
#do
#lxc file push --uid 0 --gid 0 ./hosts node$i/etc/hosts
#lxc exec node$i --cwd /opt -- wget https://dlcdn.apache.org/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz
#lxc exec node$i --cwd /opt -- tar -xvf apache-zookeeper-3.7.1-bin.tar.gz
#lxc exec node$i --cwd /opt -- mv apache-zookeeper-3.7.1-bin zookeeper
#lxc exec node$i --cwd /opt -- rm apache-zookeeper-3.7.1-bin.tar.gz
#lxc file push --uid 0 --gid 0 files/zoo.cfg node$i/opt/zookeeper/conf/zoo.cfg
#lxc exec node$i -- mkdir /var/lib/zookeeper
#lxc exec node$i -- mkdir /var/log/zookeeper
#lxc exec node$i -- bash -c "echo  $i> /var/lib/zookeeper/myid"
#lxc exec node$i -- useradd zookeeper -m
#lxc exec node$i -- usermod --shell /bin/bash zookeeper
#lxc file push --uid 0 --gid 0 files/zookeeper.service node$i/etc/systemd/system/zookeeper.service
#lxc exec node$i -- chown zookeeper:zookeeper -R /opt/zookeeper
#lxc exec node$i -- chown zookeeper:zookeeper -R /var/lib/zookeeper
#lxc exec node$i -- chown zookeeper:zookeeper -R /var/log/zookeeper
#lxc exec node$i exec -- systemctl enable zookeeper
#lxc exec node$i exec -- systemctl start zookeeper
#done
#
#
#for i in 1 2 3;
#do
#lxc exec node$i --cwd /opt -- wget https://downloads.apache.org/kafka/3.2.1/kafka_2.13-3.2.1.tgz
#lxc exec node$i --cwd /opt -- tar -xvf kafka_2.13-3.2.1.tgz
#lxc exec node$i --cwd /opt -- mv kafka_2.13-3.2.1 kafka
#lxc exec node$i --cwd /opt -- rm kafka_2.13-3.2.1.tgz
#lxc file push --uid 0 --gid 0 files/server.properties node$i/opt/zookeeper/config/server.properties
#lxc exec node$i --cwd /opt/kafka/config -- sed -i "s/broker.id=1/broker.id=$i/g" server.properties
#lxc exec node$i -- mkdir /var/lib/kafka
#lxc exec node$i -- mkdir /var/log/kafka
#lxc exec node$i -- useradd kafka -m
#lxc exec node$i -- usermod --shell /bin/bash kafka
#lxc file push --uid 0 --gid 0 files/kafka.service node$i/etc/systemd/system/kafka.service
#lxc exec node$i -- chown kafka:kafka -R /opt/kafka
#lxc exec node$i -- chown kafka:kafka -R /var/lib/kafka
#lxc exec node$i -- chown kafka:kafka -R /var/log/kafka
#lxc exec node$i exec -- systemctl enable kafka
#lxc exec node$i exec -- systemctl start kafka
#done
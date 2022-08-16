#!/bin/bash
for i in 1 2 3;
do
lxc file push --uid 0 --gid 0 ./hosts node$i/etc/hosts
lxc exec node$i --cwd /opt -- wget https://dlcdn.apache.org/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz
lxc exec node$i --cwd /opt -- tar -xf apache-zookeeper-3.7.1-bin.tar.gz
lxc exec node$i --cwd /opt -- mv apache-zookeeper-3.7.1-bin zookeeper
lxc exec node$i --cwd /opt -- rm apache-zookeeper-3.7.1-bin.tar.gz
lxc file push --uid 0 --gid 0 files/zoo.cfg node$i/opt/zookeeper/conf/zoo.cfg
lxc exec node$i -- mkdir /var/lib/zookeeper
lxc exec node$i -- mkdir /var/log/zookeeper
lxc exec node$i -- bash -c "echo  $i > /var/lib/zookeeper/myid"
lxc exec node$i -- useradd zookeeper -m
lxc exec node$i -- usermod --shell /bin/bash zookeeper
lxc file push --uid 0 --gid 0 files/zookeeper.service node$i/etc/systemd/system/zookeeper.service
lxc exec node$i -- chown zookeeper:zookeeper -R /opt/zookeeper
lxc exec node$i -- chown zookeeper:zookeeper -R /var/lib/zookeeper
lxc exec node$i -- chown zookeeper:zookeeper -R /var/log/zookeeper
lxc exec node$i exec -- systemctl enable zookeeper
done
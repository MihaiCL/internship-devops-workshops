#!/bin/bash
for i in 1 2 3;
do
lxc exec node$i --cwd /opt -- wget https://downloads.apache.org/kafka/3.2.1/kafka_2.13-3.2.1.tgz
lxc exec node$i --cwd /opt -- tar -xf kafka_2.13-3.2.1.tgz
lxc exec node$i --cwd /opt -- mv kafka_2.13-3.2.1 kafka
lxc exec node$i --cwd /opt -- rm kafka_2.13-3.2.1.tgz
lxc file push --uid 0 --gid 0 files/server.properties node$i/opt/kafka/config/server.properties
lxc exec node$i --cwd /opt/kafka/config -- sed -i "s/broker.id=0/broker.id=$i/g" server.properties
lxc exec node$i -- mkdir /var/lib/kafka
lxc exec node$i -- mkdir /var/log/kafka
lxc exec node$i -- useradd kafka -m
lxc exec node$i -- usermod --shell /bin/bash kafka
lxc file push --uid 0 --gid 0 files/kafka.service node$i/etc/systemd/system/kafka.service
lxc exec node$i -- chown kafka:kafka -R /opt/kafka
lxc exec node$i -- chown kafka:kafka -R /var/lib/kafka
lxc exec node$i -- chown kafka:kafka -R /var/log/kafka
lxc exec node$i exec -- systemctl enable kafka
done
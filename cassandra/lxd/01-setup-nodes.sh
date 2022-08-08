#!/bin/bash
for i in 1 2 3;
do
lxc launch images:ubuntu/20.04 cassandra-node$i
lxc config set cassandra-node$i limits.memory 2GB
lxc config set cassandra-node$i limits.cpu.allowance 20%
lxc config show cassandra-node$i
lxc file push --create-dirs --uid 0 --gid 0 ~/.ssh/id_rsa.pub cassandra-node$i/root/.ssh/authorized_keys

done

lxc list -c 4,n -f csv | sed 's/ (eth0),/ /g' > hosts

for i in 1 2 3;
do
lxc exec cassandra-node$i -- apt install ssh -y
lxc file push --uid 0 --gid 0 files/sshd_config cassandra-node$i/etc/ssh/sshd_config
lxc exec cassandra-node$i systemctl restart ssh
lxc exec cassandra-node$i -- apt install curl -y
lxc exec cassandra-node$i -- apt install gnupg2 -y
lxc exec cassandra-node$i -- bash -c 'echo "deb http://www.apache.org/dist/cassandra/debian 40x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list'
lxc exec cassandra-node$i -- bash -c 'curl https://downloads.apache.org/cassandra/KEYS | apt-key add -'
lxc exec cassandra-node$i -- apt update
lxc exec cassandra-node$i -- apt install cassandra -y
lxc exec cassandra-node$i -- systemctl stop cassandra
lxc file push --uid 0 --gid 0 ./hosts cassandra-node$i/etc/hosts
lxc exec cassandra-node$i -- rm -fr /var/lib/cassandra/*
lxc file push --uid 0 --gid 0 files/cassandra.yaml cassandra-node$i/etc/cassandra/cassandra.yaml
lxc exec cassandra-node$i rm /etc/cassandra/cassandra-topology.properties
done


# de prezentat ca putem avea acelasi fisier de configurare
# de prezentat optinea prin care pe hdd-uri diferite putem salva datele /log-urile
#
./nodetool -u 'k8ssandra-superuser' -pw 't76kxTl8tWn4Z9uelSyW' status
./cqlsh -u 'k8ssandra-superuser' -p 't76kxTl8tWn4Z9uelSyW'
describe keyspaces;
create keyspace if not exists facebook with replication = { 'class' : 'NetworkTopologyStrategy', 'dc1': 3 };
use facebook;

create table users (id int, name text, age int, primary key (id));
insert into users(id, name, age) values (1, 'Mihai', 21);
insert into users(id, name, age) values (2, 'Vali', 25);
insert into users(id, name, age) values (3, 'Radu', 23);
select * from users;

CONSISTENCY ALL;
insert into users(id, name, age) values (4, 'Hagi', 60);
select * from users;

kubectl cordon kind-worker;
kubectl cordon kind-worker2;
kubectl cordon kind-worker3;
kubectl cordon kind-worker4;
kubectl cordon kind-worker5;

CONSISTENCY QUORUM;
insert into users(id, name, age) values (5, 'Radoi', 50);
select * from users;

CONSISTENCY ONE;
insert into users(id, name, age) values (6, 'Ronaldo', 32);
select * from users;
#CONTROLLER 
#NTP
apt install chrony -y
apt install crudini -y
crudini --set /etc/chrony/chrony.conf allow 10.0.2.0/24
service chrony restart

#openstack packages
add-apt-repository cloud-archive:antelope

#sample installation
apt install nova-compute

#client installation
apt install python3-openstackclient

#SQL Database
apt install mariadb-server python3-pymysql

crudini --set /etc/mysql/mariadb.conf.d/99-openstack.cnf mysqld bind-address = 10.0.0.11 #change IP 
crudini --set /etc/mysql/mariadb.conf.d/99-openstack.cnf mysqld default-storage-engine = innodb
crudini --set /etc/mysql/mariadb.conf.d/99-openstack.cnf mysqld innodb_file_per_table = on
crudini --set /etc/mysql/mariadb.conf.d/99-openstack.cnf mysqld max_connections = 4096
crudini --set /etc/mysql/mariadb.conf.d/99-openstack.cnf mysqld collation-server = utf8_general_ci
crudini --set /etc/mysql/mariadb.conf.d/99-openstack.cnf mysqld character-set-server = utf8

service mysql restart
mysql_secure_installation

#message queue
apt install rabbitmq-server -y
rabbitmqctl add_user openstack idrbt
rabbitmqctl set_permissions openstack ".*" ".*" ".*"

#Memcached
apt install memcached python3-memcache
crudini --set /etc/memcached.cnf -l 10.0.0.11 #change IP
service memcached restart

#ETCD
apt install etcd -y
crudini --set /etc/default/etcd ETCD_NAME="controller"
crudini --set /etc/default/etcd ETCD_DATA_DIR="/var/lib/etcd"
crudini --set /etc/default/etcd ETCD_INITIAL_CLUSTER_STATE="new"
crudini --set /etc/default/etcd ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster-01"
crudini --set /etc/default/etcd ETCD_INITIAL_CLUSTER="controller=http://10.0.0.11:2380"
crudini --set /etc/default/etcd ETCD_INITIAL_ADVERTISE_PEER_URLS="http://10.0.0.11:2380"
crudini --set /etc/default/etcd ETCD_ADVERTISE_CLIENT_URLS="http://10.0.0.11:2379"
crudini --set /etc/default/etcd ETCD_LISTEN_PEER_URLS="http://0.0.0.0:2380"
crudini --set /etc/default/etcd ETCD_LISTEN_CLIENT_URLS="http://10.0.0.11:2379"

systemctl enable etcd
systemctl restart etcd

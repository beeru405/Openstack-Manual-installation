#Placement
apt install placement-api -y
crudini --set /etc/placement/placement.conf placement_database connection = mysql+pymysql://placement:idrbt@controller/placement
crudini --set /etc/placement/placement.conf api auth_strategy = keystone
crudini --set /etc/placement/placement.conf keystone_authtoken auth_url = http://controller:5000/v3 
crudini --set /etc/placement/placement.conf keystone_authtoken memcached_servers = controller:11211
crudini --set /etc/placement/placement.conf keystone_authtoken auth_type = password
crudini --set /etc/placement/placement.conf keystone_authtoken project_domain_name = Default
crudini --set /etc/placement/placement.conf keystone_authtoken user_domain_name = Default
crudini --set /etc/placement/placement.conf keystone_authtoken project_name = service
crudini --set /etc/placement/placement.conf keystone_authtoken username = placement
crudini --set /etc/placement/placement.conf keystone_authtoken password = idrbt

su -s /bin/sh -c "placement-manage db sync" placement
service apache2 restart

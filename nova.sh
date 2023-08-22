#NOVA
apt install nova-api nova-conductor nova-novncproxy nova-scheduler
crudini --set /etc/nova/nova.conf api_database connection = mysql+pymysql://nova:idrbt@controller/nova_api
crudini --set /etc/nova/nova.conf database connection = mysql+pymysql://nova:idrbt@controller/nova
crudini --set /etc/nova/nova.conf DEFAULT transport_url = rabbit://openstack:idrbt@controller:5672/
crudini --set /etc/nova/nova.conf api auth_strategy = keystone
crudini --set /etc/nova/nova.conf keystone_authtoken www_authenticate_uri = http://controller:5000/
crudini --set /etc/nova/nova.conf keystone_authtoken auth_url = http://controller:5000/
crudini --set /etc/nova/nova.conf keystone_authtoken memcached_servers = controller:11211
crudini --set /etc/nova/nova.conf keystone_authtoken auth_type = password
crudini --set /etc/nova/nova.conf keystone_authtoken project_domain_name = Default
crudini --set /etc/nova/nova.conf keystone_authtoken user_domain_name = Default
crudini --set /etc/nova/nova.conf keystone_authtoken project_name = service
crudini --set /etc/nova/nova.conf keystone_authtoken username = nova
crudini --set /etc/nova/nova.conf keystone_authtoken password = idrbt
crudini --set /etc/nova/nova.conf service_user send_service_user_token = true 
crudini --set /etc/nova/nova.conf service_user auth_url = https://controller/identity/v3/
crudini --set /etc/nova/nova.conf service_user auth_strategy = keystone
crudini --set /etc/nova/nova.conf service_user auth_type = password
crudini --set /etc/nova/nova.conf service_user project_domain_name = Default
crudini --set /etc/nova/nova.conf service_user project_name = service
crudini --set /etc/nova/nova.conf service_user user_domain_name = Default
crudini --set /etc/nova/nova.conf service_user username = nova
crudini --set /etc/nova/nova.conf service_user password = idrbt
crudini --set /etc/nova/nova.conf DEFAULT my_ip = 10.0.0.11 #change
crudini --set /etc/nova/nova.conf vnc enabled = true
crudini --set /etc/nova/nova.conf vnc server_listen = $my_ip
crudini --set /etc/nova/nova.conf vnc server_proxyclient_address = $my_ip
crudini --set /etc/nova/nova.conf glance api_servers = http://controller:9292
crudini --set /etc/nova/nova.conf oslo_concurrency lock_path = /var/lib/nova/tmp
crudini --set /etc/nova/nova.conf placement region_name = RegionOne
crudini --set /etc/nova/nova.conf placement project_domain_name = Default
crudini --set /etc/nova/nova.conf placement project_name = service
crudini --set /etc/nova/nova.conf placement auth_type = password
crudini --set /etc/nova/nova.conf placement user_domain_name = Default
crudini --set /etc/nova/nova.conf placement auth_url = http://controller:5000/v3
crudini --set /etc/nova/nova.conf placement username = placement
crudini --set /etc/nova/nova.conf placement password = idrbt

su -s /bin/sh -c "nova-manage api_db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova
su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
su -s /bin/sh -c "nova-manage db sync" nova

su -s /bin/sh -c "nova-manage cell_v2 list_cells" nova


service nova-api restart
service nova-scheduler restart
service nova-conductor restart
service nova-novncproxy restart

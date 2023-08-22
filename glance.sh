#Glance


apt install glance -y
crudini --set /etc/glance/glance-api.conf database connection = mysql+pymysql://glance:idrbt@controller/glance
crudini --set /etc/glance/glance-api.conf keystone_authtoken www_authenticate_uri = http://controller:5000
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_url = http://controller:5000
crudini --set /etc/glance/glance-api.conf keystone_authtoken memcached_servers = controller:11211
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_type = password
crudini --set /etc/glance/glance-api.conf keystone_authtoken project_domain_name = Default
crudini --set /etc/glance/glance-api.conf keystone_authtoken user_domain_name = Default
crudini --set /etc/glance/glance-api.conf keystone_authtoken project_name = service
crudini --set /etc/glance/glance-api.conf keystone_authtoken username = glance
crudini --set /etc/glance/glance-api.conf keystone_authtoken password = idrbt
crudini --set /etc/glance/glance-api.conf paste_deploy flavor = keystone
crudini --set /etc/glance/glance-api.conf glance_store stores = file,http
crudini --set /etc/glance/glance-api.conf glance_store default_store = file
crudini --set /etc/glance/glance-api.conf glance_store filesystem_store_datadir = /var/lib/glance/images/
crudini --set /etc/glance/glance-api.conf oslo_limit auth_url = http://controller:5000 
crudini --set /etc/glance/glance-api.conf oslo_limit auth_type = password
crudini --set /etc/glance/glance-api.conf oslo_limit user_domain_id = Default
crudini --set /etc/glance/glance-api.conf oslo_limit username = glance
crudini --set /etc/glance/glance-api.conf oslo_limit system_scope = all
crudini --set /etc/glance/glance-api.conf oslo_limit password = idrbt
crudini --set /etc/glance/glance-api.conf oslo_limit endpoint_id = ENDPOINT_ID #change
crudini --set /etc/glance/glance-api.conf oslo_limit region_name = RegionOne

openstack role add --user glance --user-domain Default --system all reader
service glance-api restart


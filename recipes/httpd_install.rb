# add hosts entry
hostsfile_entry '127.0.0.1' do
	hostname  'localhost.localdomain'
	action    :create
end

# create directory
directory '/var/www/shop' do
	owner 'root'
	group 'root'
	mode '0775'
	recursive true
	action :create
end

# create virtual host
web_app 'shop' do
	server_name 'localhost.localdomain'
	server_aliases ['localhost.localdomain']
	docroot '/var/www/shop'
	cookbook 'apache2'
end

# create dummy content
execute "create dummy site" do
	command "echo 'hello' > /var/www/shop/index.html"
	cwd "/var/www/shop"
	action :run
end

# fix owner
execute "root" do
	command "chown -R root:root ."
	cwd "/var/www/shop"
	action :run
end

# fix permission
execute "root" do
	command "chmod -R 775 ."
	cwd "/var/www/shop"
	action :run
end

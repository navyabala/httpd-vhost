# add hosts entry
hostsfile_entry '127.0.0.1' do
	hostname  'tryenbd'
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
	server_name 'tryenbd'
	server_aliases ['tryenbd']
	docroot '/var/www/shop'
	cookbook 'httpd'
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

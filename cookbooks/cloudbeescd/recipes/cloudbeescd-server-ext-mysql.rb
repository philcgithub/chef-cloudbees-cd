#
# Cookbook:: cloudbeescd
# Recipe:: cloudbeescd-server
#
# Copyright:: 2021, The Authors, All Rights Reserved.

user = "#{node['cloudbeescd']['installer-user-name']}"
installer_path = "#{node['cloudbeescd']['installer-path']}"
server_installer_file = "#{node['cloudbeescd']['server-installer-file']}"
config_bag = data_bag_item('cloudbeescd', 'config')
db_password = config_bag['db-password']
admin_password = config_bag['admin-password']
database_name = "#{node['cloudbeescd']['database-name']}"
database_port = "#{node['cloudbeescd']['database-port']}"
database_host = "#{node['cloudbeescd']['database-host']}"
database_user_name = "#{node['cloudbeescd']['database-user-name']}"
install_dir = "#{node['cloudbeescd']['install-dir']}"

# Run the installer
cloudbeescd_server 'server1' do
  installer_path "#{installer_path}"
  server_installer_file "#{server_installer_file}"
  user "#{user}"
  flags "--installServer --installWeb --installAgent --installRepository --unixServerUser #{user} --unixServerGroup #{user} --useSameServiceAccount"
  action :create
end

# Copy myql connector java in to the right location
cookbook_file "#{install_dir}/server/lib/mysql-connector-java.jar" do
  source 'mysql-connector-java-8.0.22.jar'
  owner "#{user}"
  group "#{user}"
  action :create
end

# Restart the CloudBees CD Server
cloudbeescd_server 'server1' do
  action :restart
end

# Wait for server to be ready for database configuration
cloudbeescd_server 'server1' do
  install_dir "#{install_dir}"
  action :waitForStartPreDbConfig
end

# Set database configuration
cloudbeescd_server 'server1' do
  flags "--databaseType mysql --databaseName #{database_name} --hostName #{database_host} --port #{database_port} --userName #{database_user_name} --password #{db_password}"
  user "#{user}"
  install_dir "#{install_dir}"
  action :setDatabaseConfiguration
end

# Check server setup has finished
cloudbeescd_server 'server1' do
  install_dir "#{install_dir}"
  action :waitForSetup
end

# Change admin password using ectool
cloudbeescd_server 'server1' do
  admin_password "#{admin_password}"
  install_dir "#{install_dir}"
  action :setAdminPwd
end

# Copy license file if supplied
cloudbeescd_server 'server1' do
  user "#{user}"
  install_dir "#{install_dir}"
  action :importLicense
end

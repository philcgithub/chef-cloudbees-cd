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

# Run the installer
cloudbeescd_server 'server1' do
  installer_path "#{installer_path}"
  server_installer_file "#{server_installer_file}"
  user "#{user}"
  flags "--installServer --installWeb --installAgent --installRepository --unixServerUser #{user} --unixServerGroup #{user} --useSameServiceAccount --installDatabase --databasePassword #{db_password}"
  action :create
end

# Check server setup has finished
cloudbeescd_server 'server1' do
  action :waitForSetup
end

# Change admin password using ectool
cloudbeescd_server 'server1' do
  admin_password "#{admin_password}"
  action :setAdminPwd
end

# Copy license file if supplied
cloudbeescd_server 'server1' do
  user "#{user}"
  action :importLicense
end
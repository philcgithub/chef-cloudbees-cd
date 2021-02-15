#
# Cookbook:: cloudbeescd
# Recipe:: setup-env
#
# Copyright:: 2021, The Authors, All Rights Reserved.

user = "#{node['cloudbeescd']['installer-user-name']}"
config_bag = data_bag_item('cloudbeescd', 'config')
password = config_bag['installer-user-password']
installer_path = "#{node['cloudbeescd']['installer-path']}"
server_installer_file = "#{node['cloudbeescd']['server-installer-file']}"
analytics_installer_file = "#{node['cloudbeescd']['analytics-installer-file']}"

# Add user and set password
user "#{user}" do
  password "#{password}"
  shell '/bin/bash'
  action :create
end

# Allow this user to run installer as sudo without password
sudo 'installer' do
  users "#{user}"
  nopasswd true
  commands ["#{installer_path}/#{server_installer_file}", "#{installer_path}/#{analytics_installer_file}"]
  action :create
end

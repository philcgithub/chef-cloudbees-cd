#
# Cookbook:: cloudbees-cd
# Recipe:: setup-env
#
# Copyright:: 2021, The Authors, All Rights Reserved.

user = "#{node['cloudbees-cd']['installer-user-name']}"
config_bag = data_bag_item('cloudbees-cd', 'config')
password = config_bag['installer-user-password']
installer_path = "#{node['cloudbees-cd']['installer-path']}"
server_installer_file = "#{node['cloudbees-cd']['server-installer-file']}"
analytics_installer_file = "#{node['cloudbees-cd']['analytics-installer-file']}"

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

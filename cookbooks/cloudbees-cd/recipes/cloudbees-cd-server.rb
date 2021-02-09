#
# Cookbook:: cloudbees-cd
# Recipe:: cloudbees-cd-server
#
# Copyright:: 2021, The Authors, All Rights Reserved.

user = "#{node['cloudbees-cd']['installer-user-name']}"
installer_path = "#{node['cloudbees-cd']['installer-path']}"
server_installer_file = "#{node['cloudbees-cd']['server-installer-file']}"
config_bag = data_bag_item('cloudbees-cd', 'config')
db_password = config_bag['db-password']

# Run the installer
execute 'install-cloudbees-cd-server' do
  command "sudo #{installer_path}/#{server_installer_file} --mode silent --installServer --installWeb --installAgent --installRepository --unixServerUser #{user} --unixServerGroup #{user} --useSameServiceAccount --installDatabase --databasePassword #{db_password}"
  user "#{user}"
  group "#{user}"
  action :run
end

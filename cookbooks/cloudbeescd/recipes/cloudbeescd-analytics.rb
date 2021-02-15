#
# Cookbook:: cloudbeescd
# Recipe:: cloudbeescd-analytics
#
# Copyright:: 2021, The Authors, All Rights Reserved.

user = "#{node['cloudbeescd']['installer-user-name']}"
installer_path = "#{node['cloudbeescd']['installer-path']}"
analytics_installer_file = "#{node['cloudbeescd']['analytics-installer-file']}"
config_bag = data_bag_item('cloudbeescd', 'config')
elasticsearch_password = config_bag['elasticsearch-password']
analytics_remoteserver = "#{node['cloudbeescd']['analytics-remoteserver']}"
analytics_remoteserver_user = "#{node['cloudbeescd']['analytics-remoteserver-user']}"
admin_password = config_bag['admin-password']

# Check server setup has finished
cloudbeescd_server 'server1' do
  action :waitForSetup
end

# Run the installer
execute 'install-cloudbeescd-analytics' do
  command "sudo #{installer_path}/#{analytics_installer_file} --mode silent --elasticsearchUserPassword #{elasticsearch_password} --remoteServer #{analytics_remoteserver} --unixServerUser #{user} --unixServerGroup #{user} --remoteServerPassword #{admin_password} --remoteServerUser #{analytics_remoteserver_user}"
  user "#{user}"
  group "#{user}"
  action :run
end
#
# Cookbook:: cloudbees-cd
# Recipe:: cloudbees-cd-analytics
#
# Copyright:: 2021, The Authors, All Rights Reserved.

user = "#{node['cloudbees-cd']['installer-user-name']}"
installer_path = "#{node['cloudbees-cd']['installer-path']}"
analytics_installer_file = "#{node['cloudbees-cd']['analytics-installer-file']}"
config_bag = data_bag_item('cloudbees-cd', 'config')
elasticsearch_password = config_bag['elasticsearch-password']
analytics_remoteserver = "#{node['cloudbees-cd']['analytics-remoteserver']}"
analytics_remoteserver_user = "#{node['cloudbees-cd']['analytics-remoteserver-user']}"
analytics_remoteserver_password = config_bag['analytics-remoteserver-password']

# Check server setup has finished
ruby_block 'Wait for CloudBees CD Server setup to finish' do
  block do
    true until ::File.foreach('/opt/electriccloud/electriccommander/logs/setupScripts.log').grep(/Finished loading/).any?
    # Wait between checks
    sleep(10)
  end
  action :run
end

# Run the installer
execute 'install-cloudbees-cd-analytics' do
  command "sudo #{installer_path}/#{analytics_installer_file} --mode silent --elasticsearchUserPassword #{elasticsearch_password} --remoteServer #{analytics_remoteserver} --unixServerUser #{user} --unixServerGroup #{user} --remoteServerPassword #{analytics_remoteserver_password} --remoteServerUser #{analytics_remoteserver_user}"
  user "#{user}"
  group "#{user}"
  action :run
end

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
admin_password = config_bag['admin-password']

# Run the installer
execute 'install-cloudbees-cd-server' do
  command "sudo #{installer_path}/#{server_installer_file} --mode silent --installServer --installWeb --installAgent --installRepository --unixServerUser #{user} --unixServerGroup #{user} --useSameServiceAccount --installDatabase --databasePassword #{db_password}"
  user "#{user}"
  group "#{user}"
  action :run
end

# Check server setup has finished
ruby_block 'Wait for CloudBees CD Server setup to finish' do
  block do
    true until ::File.foreach('/opt/electriccloud/electriccommander/logs/setupScripts.log').grep(/Finished loading/).any?
    # Wait between checks
    sleep(10)
  end
  action :run
end

# Change admin password using ectool
bash 'Set admin password' do
  code <<-EOH
    /opt/electriccloud/electriccommander/bin/ectool --server localhost login "admin" "changeme"
    /opt/electriccloud/electriccommander/bin/ectool modifyUser "admin" --password "#{admin_password}" --sessionPassword "changeme"
  EOH
  action :run
end

# Copy license file if supplied
cookbook_file '/tmp/license.xml' do
  source 'license.xml'
  owner "#{user}"
  group "#{user}"
  action :create
  ignore_failure true
end

# Apply license if supplied
bash 'Apply license.xml' do
  only_if { ::File.exist?('/tmp/license.xml') }
  code <<-EOH
    /opt/electriccloud/electriccommander/bin/ectool --server localhost login "admin" "#{admin_password}"
    /opt/electriccloud/electriccommander/bin/ectool importLicenseData /tmp/license.xml
  EOH
  action :run
end

# Remove license file if it was copied over
file '/tmp/license.xml' do
  action :delete
end
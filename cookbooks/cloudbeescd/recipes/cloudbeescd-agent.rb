#
# Cookbook:: cloudbeescd
# Recipe:: cloudbeescd-agent
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# Note remote CloudBees CD Server setup must be completed before this runbook is run

# This runbook will install a single agent
# If the intention is to install multiple agents on a single server then the following flags will need to be different for each (e.g. by adding an iteration number):
# --installDirectory
# --dataDirectory
# --remoteServerResource
# --agentLocalPort
# --agentPort

user = "#{node['cloudbeescd']['installer-user-name']}"
installer_path = "#{node['cloudbeescd']['installer-path']}"
agent_installer_file = "#{node['cloudbeescd']['agent-installer-file']}"
config_bag = data_bag_item('cloudbeescd', 'config')
agent_remoteserver = "#{node['cloudbeescd']['agent-remoteserver']}"
agent_remoteserver_user = "#{node['cloudbeescd']['agent-remoteserver-user']}"
admin_password = config_bag['admin-password']
agent_install_dir = "#{node['cloudbeescd']['agent-install-dir']}"
agent_data_dir = "#{node['cloudbeescd']['agent-data-dir']}"
agent_port = "#{node['cloudbeescd']['agent-port']}"
agent_local_port = "#{node['cloudbeescd']['agent-local-port']}"

# Run the installer
cloudbeescd_agent 'server1' do
  installer_path "#{installer_path}"
  agent_installer_file "#{agent_installer_file}"
  user "#{user}"
  flags " --installAgent  --installDirectory #{agent_install_dir}  --dataDirectory #{agent_data_dir}  --remoteServer #{agent_remoteserver}  --remoteServerUser #{agent_remoteserver_user}  --remoteServerPassword #{admin_password}  --unixAgentGroup #{user}  --unixAgentUser #{user}  --remoteServerResourceHostName #{node['fqdn']}  --remoteServerCreateResource  --remoteServerResource #{node['fqdn']}  --remoteServerDiscoverPlugins  --agentLocalPort #{agent_local_port}  --agentPort #{agent_port}"
  action :create
end

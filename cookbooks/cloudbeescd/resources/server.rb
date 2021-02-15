property :instance_name, String, name_property: true
property :flags, String, default: ''
installer_path = "#{node['cloudbeescd']['installer-path']}"
server_installer_file = "#{node['cloudbeescd']['server-installer-file']}"

action :create do
  execute 'install-cloudbeescd-server' do
    flags = '--mode silent '
    flags << new_resource.flags
    command "sudo #{installer_path}/#{server_installer_file} #{flags}"
    user "#{user}"
    group "#{user}"
    action :run
  end
end

action :delete do
  execute 'uninstall-cloudbeescd-server' do
    command '/opt/electriccloud/electriccommander/uninstall'
    user " #{user}"
    group "#{user}"
    action :run
  end
end

# action :importlicense do

# end

# action :setpwd do

# end

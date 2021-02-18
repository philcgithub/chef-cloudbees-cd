property :instance_name, String, name_property: true
property :flags, String, default: ''
property :admin_password, String
property :user, String
property :installer_path, String
property :server_installer_file, String

action :create do
  execute 'install-cloudbeescd-server' do
    flags = '--mode silent '
    flags << new_resource.flags
    command "sudo #{new_resource.installer_path}/#{new_resource.server_installer_file} #{flags}"
    user "#{new_resource.user}"
    group "#{new_resource.user}"
    action :run
  end
end

action :delete do
  execute 'uninstall-cloudbeescd-server' do
    command '/opt/electriccloud/electriccommander/uninstall'
    user "#{new_resource.user}"
    group "#{new_resource.user}"
    action :run
  end
end

action :waitForStartPreDbConfig do
  ruby_block 'Wait for CloudBees CD Server setup to finish' do
    block do
      true until ::File.foreach('/opt/electriccloud/electriccommander/logs/commander.log').grep(/Waiting until a valid database configuration has been supplied/).  any?
      # Wait between checks
      sleep(10)
    end
    action :run
  end
end

action :waitForSetup do
  ruby_block 'Wait for CloudBees CD Server setup to finish' do
    block do
      true until ::File.foreach('/opt/electriccloud/electriccommander/logs/setupScripts.log').grep(/Finished loading/).any?
      # Wait between checks
      sleep(10)
    end
    action :run
  end
end

action :importLicense do
  # Copy license file if supplied
  cookbook_file '/tmp/license.xml' do
    source 'license.xml'
    owner "#{new_resource.user}"
    group "#{new_resource.user}"
    action :create
    ignore_failure true
  end

  # Apply license if supplied
  bash 'Apply license.xml' do
    only_if { ::File.exist?('/tmp/license.xml') }
    code <<-EOH
      /opt/electriccloud/electriccommander/bin/ectool --server localhost login "admin" "#{new_resource.admin_password}"
      /opt/electriccloud/electriccommander/bin/ectool importLicenseData /tmp/license.xml
    EOH
    action :run
  end

  # Remove license file if it was copied over
  file '/tmp/license.xml' do
    action :delete
  end
end

action :setAdminPwd do
  bash 'Set admin password' do
    code <<-EOH
      /opt/electriccloud/electriccommander/bin/ectool --server localhost login "admin" "changeme"
      /opt/electriccloud/electriccommander/bin/ectool modifyUser "admin" --password "#{new_resource.admin_password}" --sessionPassword "changeme"
    EOH
    action :run
  end
end

action :setDatabaseConfiguration do
  bash 'Set database configuration' do
    code <<-EOH
      /opt/electriccloud/electriccommander/bin/ectool setDatabaseConfiguration #{new_resource.flags}
    EOH
    action :run
  end
end

action :restart do
  execute 'Restart CloudBees CD server' do
    command "sudo systemctl restart commanderServer"
  end
end

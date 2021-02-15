property :instance_name, String, name_property: true
property :flags, String, default: ''
property :user, String
property :installer_path, String
property :analytics_installer_file, String

action :create do
  execute 'install-cloudbeescd-analytics' do
    flags = '--mode silent '
    flags << new_resource.flags
    command "sudo #{new_resource.installer_path}/#{new_resource.analytics_installer_file} --mode silent #{flags}"
    user "#{new_resource.user}"
    group "#{new_resource.user}"
    action :run
  end
end

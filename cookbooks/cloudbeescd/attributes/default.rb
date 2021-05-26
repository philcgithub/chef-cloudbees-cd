# Where to find the installers
default['cloudbeescd']['installer-path'] = '/home/phil'
# Names of the installer files
default['cloudbeescd']['server-installer-file'] = 'CloudBeesFlow-x64-10.1.0.145850'
default['cloudbeescd']['analytics-installer-file'] = 'CloudBeesFlowDevOpsInsightServer-x64-10.1.0.145850'
default['cloudbeescd']['agent-installer-file'] = 'CloudBeesFlowAgent-x64-10.1.0.145850'
# OS user that CloudBees CD should run as
default['cloudbeescd']['installer-user-name'] = 'cloudbeescd'
# Database details if not using internal mariadb
default['cloudbeescd']['database-name'] = 'cbcd'
default['cloudbeescd']['database-port'] = '3306'
default['cloudbeescd']['database-host'] = '10.154.0.5'
default['cloudbeescd']['database-user-name'] = 'root'
# Analytics details
# Where analytics can reach CloudBees CD server
default['cloudbeescd']['analytics-remoteserver'] = 'localhost'
# Account for Analytics to connect with CloudBees CD server
default['cloudbeescd']['analytics-remoteserver-user'] = 'admin'
# Server details
# pre-10.1 the install-dir was /opt/electriccloud/electriccommander
default['cloudbeescd']['install-dir'] = '/opt/cloudbees/sda'
# Non-bound Agent details
default['cloudbeescd']['agent-install-dir'] = '/opt/cloudbees/sda/agent'
default['cloudbeescd']['agent-data-dir'] = '/opt/cloudbees/sda/agent'
default['cloudbeescd']['agent-remoteserver'] = 'localhost'
default['cloudbeescd']['agent-remoteserver-user'] = 'admin'
default['cloudbeescd']['agent-port'] = '7800'
default['cloudbeescd']['agent-local-port'] = '6800'
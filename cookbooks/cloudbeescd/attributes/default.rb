# Where to find the installers
default['cloudbeescd']['installer-path'] = '/home/phil'
# Names of the installer files
default['cloudbeescd']['server-installer-file'] = 'CloudBeesFlow-x64-10.0.2.144701'
default['cloudbeescd']['analytics-installer-file'] = 'CloudBeesFlowDevOpsInsightServer-x64-10.0.2.144701'
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
# Moved to data bag default['cloudbeescd']['analytics-remoteserver-password'] = 'changeme'
# Where to find the installers
default['cloudbees-cd']['installer-path'] = '/home/phil'
# Names of the installer files
default['cloudbees-cd']['server-installer-file'] = 'CloudBeesFlow-x64-10.0.2.144701'
default['cloudbees-cd']['analytics-installer-file'] = 'CloudBeesFlowDevOpsInsightServer-x64-10.0.2.144701'
# OS user that CloudBees CD should run as
default['cloudbees-cd']['installer-user-name'] = 'cloudbees-cd'
# Database details
# Currently uses internal mariaDB
# Analytics details
# Where analytics can reach CloudBees CD server
default['cloudbees-cd']['analytics-remoteserver'] = 'localhost'
# Account for Analytics to connect with CloudBees CD server
default['cloudbees-cd']['analytics-remoteserver-user'] = 'admin'
# Moved to data bag default['cloudbees-cd']['analytics-remoteserver-password'] = 'changeme'
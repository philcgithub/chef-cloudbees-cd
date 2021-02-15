#
# Cookbook:: cloudbeescd
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

include_recipe 'cloudbeescd::setup-env'
include_recipe 'cloudbeescd::cloudbeescd-server'
include_recipe 'cloudbeescd::cloudbeescd-analytics'

#
# Cookbook:: cloudbeescd
# Recipe:: customresourcetest
#
# Copyright:: 2021, The Authors, All Rights Reserved.

cloudbeescd_server 'test1' do
  flags '--installServer'
  action :create
end

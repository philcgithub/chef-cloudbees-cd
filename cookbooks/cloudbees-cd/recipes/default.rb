#
# Cookbook:: cloudbees-cd
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

include_recipe 'cloudbees-cd::setup-env'
include_recipe 'cloudbees-cd::cloudbees-cd-server'
include_recipe 'cloudbees-cd::cloudbees-cd-analytics'

#
# Cookbook Name:: drupal
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

#Cover the provisioning dependency for ruby-dev
package "ruby-dev" do
  action :install
end

include_recipe 'lamp'
include_recipe 'drush'

case node['drupal']['site-install']['db-url']['service']
  when 'mysql'
    include_recipe 'drupal::_database_mysql'
  when nil
    log "skipping database grants"
  else
    log "#{node['drupal']['site-install']['db-url']['service']} is not currently supported, try mysql instead" do
      level :fatal
    end
end






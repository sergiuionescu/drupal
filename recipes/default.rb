#
# Cookbook Name:: drupal-env
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'lamp'
include_recipe 'drush'

case node['drupal-env']['site-install']['db-url']['service']
  when 'mysql'
    include_recipe 'drupal-env::_database_mysql'
  when nil
    log "skipping database grants"
  else
    log "#{node['drupal-env']['site-install']['db-url']['service']} is not currently supported, try mysql instead" do
      level :fatal
    end
end

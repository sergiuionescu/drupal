#
# Cookbook Name:: drupal-env
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'lamp'
include_recipe 'drush'
include_recipe 'php::module_gd'

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

execute "download-drupal-#{node['drupal-env']['version']}" do
  cwd  '/tmp/'
  command "drush -y dl drupal-#{node['drupal-env']['version']} \
  --destination=/tmp/ \
  --drupal-project-rename=drupal-#{node['drupal-env']['version']}"
  not_if "ls /tmp/ | grep drupal-#{node['drupal-env']['version']}"
end

execute "install-drupal" do
  cwd  File.dirname(node['drupal-env']['dir'])
  command "cp -rf /tmp/drupal-#{node['drupal-env']['version']} #{node['drupal-env']['dir']} && \
  drush -y site-install -r #{node['drupal-env']['dir']} \
  --account-name=#{node['drupal-env']['site-install']['account-name']} \
  --account-pass=#{node['drupal-env']['site-install']['account-pass']} \
  --site-name=#{node['drupal-env']['site-install']['name']} \
  --db-url=#{node['drupal-env']['site-install']['db-url']['service']}://#{node['drupal-env']['site-install']['db-url']['user']}:'#{node['drupal-env']['site-install']['db-url']['password']}'@localhost/#{node['drupal-env']['site-install']['db-url']['database']} \
  --clean-url=#{node['drupal-env']['site-install']['clean-url']} \
  --clean-url=#{node['drupal-env']['site-install']['clean-url']} \
  #{node['drupal-env']['site-install']['profile'].empty? ? '' : '--profile='}#{node['drupal-env']['site-install']['profile']} \
  #{node['drupal-env']['site-install']['db-su'].empty? ? '' : '--db-su='}#{node['drupal-env']['site-install']['db-su']} \
  #{node['drupal-env']['site-install']['db-su-pw'].empty? ? '' : '--db-su-pw='}#{node['drupal-env']['site-install']['db-su-pw']} \
  #{node['drupal-env']['site-install']['site-name'].empty? ? '' : '--site-name='}#{node['drupal-env']['site-install']['site-name']} \
  #{node['drupal-env']['site-install']['sites-subdir'].empty? ? '' : '--sites-subdir='}#{node['drupal-env']['site-install']['sites-subdir']} \
  #{node['drupal-env']['site-install']['locale'].empty? ? '' : '--locale='}#{node['drupal-env']['site-install']['locale']}"
  not_if "drush -r #{node['drupal-env']['dir']} status | grep #{node['drupal-env']['version']}"
end
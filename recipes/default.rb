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

execute "download-drupal-#{node['drupal']['version']}" do
  cwd  '/tmp/'
  command "drush -y dl drupal-#{node['drupal']['version']} \
  --destination=/tmp/ \
  --drupal-project-rename=drupal-#{node['drupal']['version']}"
  not_if "ls /tmp/drupal-#{node['drupal']['version']} | grep drupal-#{node['drupal']['version']}"
end

execute "#{node['drupal']['site-install']['name']} drush-site-install" do
  cwd  File.dirname(node['drupal']['dir'])
  command "cp -rf /tmp/drupal-#{node['drupal']['version']} #{node['drupal']['dir']} && \
  drush -y site-install -r #{node['drupal']['dir']} \
  --account-name=#{node['drupal']['site-install']['account-name']} \
  --account-pass=#{node['drupal']['site-install']['account-pass']} \
  --site-name=#{node['drupal']['site-install']['name']} \
  --db-url=#{node['drupal']['site-install']['db-url']['service']}://#{node['drupal']['site-install']['db-url']['user']}:'#{node['drupal']['site-install']['db-url']['password']}'@#{node['drupal']['site-install']['db-url']['host']}/#{node['drupal']['site-install']['db-url']['database']} \
  #{node['drupal']['site-install']['profile'].empty? ? '' : '--profile='}#{node['drupal']['site-install']['profile']} \
  #{node['drupal']['site-install']['db-su'].empty? ? '' : '--db-su='}#{node['drupal']['site-install']['db-su']} \
  #{node['drupal']['site-install']['db-su-pw'].empty? ? '' : '--db-su-pw='}#{node['drupal']['site-install']['db-su-pw']} \
  #{node['drupal']['site-install']['site-name'].empty? ? '' : '--site-name='}#{node['drupal']['site-install']['site-name']} \
  #{node['drupal']['site-install']['sites-subdir'].empty? ? '' : '--sites-subdir='}#{node['drupal']['site-install']['sites-subdir']} \
  #{node['drupal']['site-install']['locale'].empty? ? '' : '--locale='}#{node['drupal']['site-install']['locale']}"
  not_if "drush -r #{node['drupal']['dir']} status | grep Drupal |grep #{node['drupal']['version']}"
end

execute "#{node['drupal']['site-install']['site-name']} permissions" do
  command "chown #{node['apache']['user']}:#{node['apache']['group']} -R #{node['drupal']['dir']}"
end





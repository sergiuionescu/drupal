#
# Cookbook Name:: drupal
# Recipe:: test
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

# Start drupal install
drupal_app "drupal" do
  action :create
end
web_app node['drupal']['site-install']['site-name'] do
  template "drupal.conf.erb"
  docroot node['drupal']['dir']
  server_name node['fqdn']
  server_aliases node['drupal']['aliases']
end

cron_d "#{node['drupal']['site-install']['site-name']} cron" do
  command "cd #{node['drupal']['dir']}; /usr/bin/php cron.php"
  user    node['apache']['user']
end
# End drupal install

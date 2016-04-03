#
# Cookbook Name:: drupal
# Recipe:: test
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

# Start drupal install
drupal_app "drupal" do
  action :create
end

web_app "drupal" do
  template "drupal.conf.erb"
  docroot "/var/www/drupal"
  server_name node['fqdn']
  server_aliases node['drupal']['aliases']
end

cron_d "drupal cron" do
  command "cd /var/www/drupal; /usr/bin/php cron.php"
  user    node['apache']['user']
end
# End drupal install

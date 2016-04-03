#
# Cookbook Name:: drupal
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

actions :create, :delete
default_action :create

attribute :app_name, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String, :default => node['drupal']['version']
attribute :si_account_name, :kind_of => String, :default => node['drupal']['site-install']['account-name']
attribute :si_account_pass, :kind_of => String, :default => node['drupal']['site-install']['account-pass']
attribute :si_db_service, :kind_of => String, :default => node['drupal']['site-install']['db-url']['service']
attribute :si_db_user, :kind_of => String, :default => node['drupal']['site-install']['db-url']['user']
attribute :si_db_password, :kind_of => String, :default => node['drupal']['site-install']['db-url']['password']
attribute :si_db_host, :kind_of => String, :default => node['drupal']['site-install']['db-url']['host']
attribute :si_db_database, :kind_of => String, :default => node['drupal']['site-install']['db-url']['database']
attribute :si_profile, :kind_of => String, :default => node['drupal']['site-install']['profile']
attribute :si_db_su, :kind_of => String, :default => node['drupal']['site-install']['db-su']
attribute :si_db_pw, :kind_of => String, :default => node['drupal']['site-install']['db-su-pw']
attribute :si_sites_subdir, :kind_of => String, :default => node['drupal']['site-install']['sites-subdir']
attribute :si_locale, :kind_of => String, :default => node['drupal']['site-install']['sites-subdir']
attribute :web_user, :kind_of => String, :default => node['apache']['user']
attribute :web_group, :kind_of => String, :default => node['apache']['group']

attr_accessor :app_root
attr_accessor :exists
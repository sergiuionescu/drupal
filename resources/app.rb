#
# Cookbook Name:: drupal
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

actions :create, :delete
default_action :create

attribute :app_name, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String, :default => node['drupal']['version']

attr_accessor :app_root
attr_accessor :exists
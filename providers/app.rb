#
# Cookbook Name:: drupal
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

use_inline_resources

def whyrun_supported?
  true
end

action :create do
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    converge_by("Create #{ @new_resource }") do
      create_app
    end
  end
end

action :delete do
  if @current_resource.exists
    converge_by("Delete #{ @new_resource }") do
      delete_app
    end
  else
    Chef::Log.info "#{ @current_resource } not found - nothing to do."
  end
end

def load_current_resource
  @current_resource = Chef::Resource::LaravelApp.new(@new_resource)

  @current_resource.name(@new_resource.name)
  @current_resource.app_name(@new_resource.app_name)
  @current_resource.app_root = "/var/www/#{@new_resource.name}"

  if application_installed?(@current_resource.app_root)
    @current_resource.exists = true
  end
end

def application_installed?(path)
  Dir.exist?(path)
end

def create_app
  
end

def delete_app
  execute "drupal-delete-#{current_resource.app_name}" do
    command "rm -rf #{current_resource.app_root}"
  end
end

def download_drupal
  execute "download-drupal-#{node['drupal']['version']}" do
    cwd  '/tmp/'
    command "drush -y dl drupal-#{node['drupal']['version']} \
  --destination=/tmp/ \
  --drupal-project-rename=drupal-#{node['drupal']['version']}"
    not_if "ls /tmp/drupal-#{node['drupal']['version']} | grep drupal-#{node['drupal']['version']}"
  end
end
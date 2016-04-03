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
    converge_by("Download drupal for #{ @new_resource }") do
      download_drupal
    end
    converge_by("Create #{ @new_resource }") do
      create_db
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
  @current_resource = Chef::Resource::DrupalApp.new(@new_resource)

  @current_resource.name(@new_resource.name)
  @current_resource.app_name(@new_resource.app_name)
  @current_resource.app_root = "/var/www/#{@new_resource.name}"
  @current_resource.version(@new_resource.version)
  @current_resource.si_account_name(@new_resource.si_account_name)
  @current_resource.si_account_pass(@new_resource.si_account_pass)
  @current_resource.si_db_service(@new_resource.si_db_service)
  @current_resource.si_db_user(@new_resource.si_db_user)
  @current_resource.si_db_password(@new_resource.si_db_password)
  @current_resource.si_db_host(@new_resource.si_db_host)
  @current_resource.si_db_database(@new_resource.si_db_database)
  @current_resource.si_profile(@new_resource.si_profile)
  @current_resource.si_db_su(@new_resource.si_db_su)
  @current_resource.si_db_pw(@new_resource.si_db_pw)
  @current_resource.si_sites_subdir(@new_resource.si_sites_subdir)
  @current_resource.si_locale(@new_resource.si_locale)
  @current_resource.web_user(@new_resource.web_user)
  @current_resource.web_group(@new_resource.web_group)

  if application_installed?(@current_resource.app_root)
    @current_resource.exists = true
  end
end

def application_installed?(path)
  Dir.exist?(path)
end

def create_app
  execute "#{current_resource.app_name} drush-site-install" do
    cwd  '/var/www/'
    command "cp -rf /tmp/drupal-#{current_resource.version} #{current_resource.app_root} && \
    drush -y site-install -r #{current_resource.app_root} \
    --account-name=#{current_resource.si_account_name} \
    --account-pass=#{current_resource.si_account_pass} \
    --site-name=#{current_resource.app_name} \
    --db-url=#{current_resource.si_db_service}://#{current_resource.si_db_user}:'#{current_resource.si_db_password}'@#{current_resource.si_db_host}/#{current_resource.si_db_database} \
            #{current_resource.si_profile.empty? ? '' : '--profile='}#{current_resource.si_profile} \
            #{current_resource.si_db_su.empty? ? '' : '--db-su='}#{current_resource.si_db_su} \
            #{current_resource.si_db_pw.empty? ? '' : '--db-su-pw='}#{current_resource.si_db_pw} \
            #{current_resource.si_sites_subdir.empty? ? '' : '--sites-subdir='}#{current_resource.si_sites_subdir} \
            #{current_resource.si_locale.empty? ? '' : '--locale='}#{current_resource.si_locale}"
    not_if "drush -r #{current_resource.app_root} status | grep Drupal |grep #{current_resource.version}"
  end
  execute "#{current_resource.app_name} permission" do
    command "chown #{current_resource.web_user}:#{current_resource.web_group} -R #{current_resource.app_root}"
  end
end

def delete_app
  execute "drupal-delete-#{current_resource.app_name}" do
    command "rm -rf #{current_resource.app_root}"
  end
end

def download_drupal
  execute "download-drupal-#{current_resource.version}" do
    cwd  '/tmp/'
    command "drush -y dl drupal-#{current_resource.version} \
  --destination=/tmp/ \
  --drupal-project-rename=drupal-#{current_resource.version}"
    not_if "ls /tmp/drupal-#{current_resource.version} | grep drupal-#{current_resource.version}"
  end
end

def create_db
  mysql_connection_info = {:host => current_resource.si_db_host,
                           :username => 'root',
                           :password => node['lamp']['mysql']['root_password']}

  mysql_database current_resource.si_db_database do
    connection mysql_connection_info
    action :create
  end

  mysql_database_user current_resource.si_db_user do
    connection mysql_connection_info
    password current_resource.si_db_password
    database_name current_resource.si_db_database
    privileges [:all]
    action :grant
  end
end
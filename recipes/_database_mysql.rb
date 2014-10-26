include_recipe 'database::mysql'

mysql_connection_info = {:host => node['drupal-env']['site-install']['db-url']['host'],
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

mysql_database node['drupal-env']['site-install']['db-url']['database'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['drupal-env']['site-install']['db-url']['user'] do
  connection mysql_connection_info
  password node['drupal-env']['site-install']['db-url']['password']
  database_name node['drupal-env']['site-install']['db-url']['database']
  privileges [:all]
  action :grant
end


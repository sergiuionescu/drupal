execute "mysql-install-drupal-privileges" do
  command "/usr/bin/mysql -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p'}#{node['mysql']['server_root_password']} < /etc/mysql/drupal-grants.sql"
  action :nothing
end

template "/etc/mysql/drupal-grants.sql" do
  path "/etc/mysql/drupal-grants.sql"
  source "grants.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  variables(
      :user     => node['drupal-env']['site-install']['db-url']['user'],
      :password => node['drupal-env']['site-install']['db-url']['password'],
      :database => node['drupal-env']['site-install']['db-url']['schema']
  )
  notifies :run, 'execute[mysql-install-drupal-privileges]', :immediately
end
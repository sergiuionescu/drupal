
default['drupal']['version'] = '8'

default['drupal']['aliases'] = ['drupal.local']

#uid1 email. Defaults to admin@example.com
default['drupal']['site-install']['account-mail'] = 'admin@example.com'
#uid1 name. Defaults to admin
default['drupal']['site-install']['account-name'] = 'admin'
#uid1 pass. Defaults to admin
default['drupal']['site-install']['account-pass'] = 'admin'
#Database service used as the drupal backend. This cookbook does not currently install any other service than mysql.
default['drupal']['site-install']['db-url']['service'] = 'mysql'
#Database user used
default['drupal']['site-install']['db-url']['user'] = 'drupal'
#Database password used
default['drupal']['site-install']['db-url']['password'] = 'drupal'
#Database host used
default['drupal']['site-install']['db-url']['host'] = '127.0.0.1'
#Database schema/database name
default['drupal']['site-install']['db-url']['database'] = 'drupal'

#the install profile you wish to run. defaults to 'default' in D6, 'standard' in D7+
default['drupal']['site-install']['profile'] = ''
#An optional table prefix to use for initial install.
default['drupal']['site-install']['db-prefix'] = ''
#Account to use when creating a new database. Must have Grant permission (mysql only). Optional.
default['drupal']['site-install']['db-su'] = ''
#Password for the "db-su" account. Optional.
default['drupal']['site-install']['db-su-pw'] = ''
#Defaults to Site-Install
default['drupal']['site-install']['site-name'] = 'drupal'
#Name of directory under 'sites' which should be created. Only needed when the subdirectory does not already exist. Defaults to 'default'
default['drupal']['site-install']['sites-subdir'] = ''
#A short language code. Sets the default site language. Language files must already be present. You may use download command to get them.
default['drupal']['site-install']['locale'] = ''

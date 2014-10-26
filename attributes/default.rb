
#uid1 email. Defaults to admin@example.com
default['drupal-env']['site-install']['account-mail'] = 'admin@example.com'
#uid1 name. Defaults to admin
default['drupal-env']['site-install']['account-name'] = 'admin'
#uid1 pass. Defaults to admin
default['drupal-env']['site-install']['account-pass'] = 'admin'
#Defaults to 1
default['drupal-env']['site-install']['clean-url'] = '1'
#Database service used as the drupal backend. This cookbook does not currently install any other service than mysql.
default['drupal-env']['site-install']['db-url']['service'] = 'mysql'
#Database user used
default['drupal-env']['site-install']['db-url']['user'] = 'drupal'
#Database password used
default['drupal-env']['site-install']['db-url']['password'] = 'drupal'
#Database host used
default['drupal-env']['site-install']['db-url']['host'] = 'localhost'
#Database schema/database name
default['drupal-env']['site-install']['db-url']['database'] = 'drupal'




#the install profile you wish to run. defaults to 'default' in D6, 'standard' in D7+
default['drupal-env']['site-install']['profile'] = nil
#An optional table prefix to use for initial install.
default['drupal-env']['site-install']['db-prefix'] = nil
#Account to use when creating a new database. Must have Grant permission (mysql only). Optional.
default['drupal-env']['site-install']['db-su'] = nil
#Password for the "db-su" account. Optional.
default['drupal-env']['site-install']['db-su-pw'] = nil
#Defaults to Site-Install
default['drupal-env']['site-install']['site-name'] = nil
#Name of directory under 'sites' which should be created. Only needed when the subdirectory does not already exist. Defaults to 'default'
default['drupal-env']['site-install']['sites-subdir'] = nil
#A short language code. Sets the default site language. Language files must already be present. You may use download command to get them.
default['drupal-env']['site-install']['locale'] = nil

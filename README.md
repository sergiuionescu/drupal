drupal
==========

Drupal environment with Berkshelf Chef and Vagrant support

Php7 support via ppa:ondrej/php.

Requirements
------------
* chef-dk
* chef-solo
* berkshelf

Extra development requirements
-----------------------------
* vagrant
* virtualbox

Resources links
---------------
* Chef DK(includes Berkshelf): https://downloads.getchef.com/chef-dk/
* Vagrant: https://www.vagrantup.com/downloads.html
* Virtualbox: https://www.virtualbox.org/wiki/Downloads


How to test dev environment
---------------------------
- Clone the repository
- Go to the project root
- Run "kitchen converge default-ubuntu-1404"

Customizing your dev environment
--------------------------------
The role used to provision the dev environment, you can create your own role to fit your needs:
```json
{
    "name": "drupal",
    "chef_type": "role",
    "json_class": "Chef::Role",
    "description": "Drupal environment configuration.",
    "run_list": [
        "recipe[drupal]",
        "recipe[lamp::nfs]",
        "recipe[lamp::xdebug]"
    ],
    "default_attributes": {
        "lamp": {
            "xdebug": {
                "directives": {
                    "remote_host": "10.0.2.2",
                    "remote_enable": 0,
                    "remote_autostart": 1
                }
            }
        }
    }
}
```

Details:
```json
"run_list": [
        "recipe[drupal]",
        "recipe[lamp::nfs]",
        "recipe[lamp::xdebug]"
    ],
```
The recipes lamp::nfs and lamp::xdebug are only required for the dev environment to expose a nfs share of your /var/www directory and install the xdebug extension for php.


```json
"mysql": {
    "server_root_password": "",
    "server_repl_password": "",
    "server_debian_password": ""
}
```
Configure your mysql dev server credentials.

```json
"lamp": {
    "xdebug": {
        "directives": {
            "remote_host": "10.0.2.2",
            "remote_enable": 0,
            "remote_autostart": 1
        }
    }
}
```
Set the xdebug configuration, all xdebug configuration directives are supported here. In this example xdebug is connecting back on the vm's NAT interface, 
configured to start the debugging session automatically but disabled. You need to enable it manually by editing your xdebug.ini.

Sample role with php7 support.

Php 7 is supported via ppa. The are a number of overwrite attributes that need to be set as long with a path for the php cookbook to disable pear and pecl update.
```json
{
    "name": "drupal",
    "chef_type": "role",
    "json_class": "Chef::Role",
    "description": "Drupal environment configuration.",
    "run_list": [
        "recipe[drupal]",
        "recipe[drupal::test]",
        "recipe[lamp::nfs]",
        "recipe[lamp::xdebug]"
    ],
    "default_attributes": {
        "lamp": {
            "xdebug": {
                "directives": {
                    "remote_host": "10.0.2.2",
                    "remote_enable": 0,
                    "remote_autostart": 1
                }
            }
        }
    },
    "override_attributes": {
        "php": {
            "version": "7.0",
            "conf_dir": "/etc/php/7.0/cli",
            "packages": [
                "php7.0-cgi",
                "php7.0",
                "php7.0-dev",
                "php7.0-cli",
                "php7.0-json",
                "php7.0-curl",
                "php7.0-mbstring",
                "php7.0-gd",
                "php-mysql",
                "php-pear"
            ],
            "mysql": {
                "package": "php7.0-pdo-mysql"
            },
            "fpm_package": "php7.0-fpm",
            "fpm_pooldir": "/etc/php/7.0/fpm/pool.d",
            "fpm_service": "php7.0-fpm",
            "fpm_default_conf": "/etc/php/7.0/fpm/pool.d/www.conf"
        }
    }
}
```

Customizing the role in production
----------------------------------

An example role for production would be the following:
```json
{
    "name": "drupal",
    "chef_type": "role",
    "json_class": "Chef::Role",
    "description": "Drupal environment configuration.",
    "run_list": [
        "recipe[drupal]"
    ],
    "default_attributes": {
        "lamp": {
            "mysql": {
                "root_password": "mysupersecretpassword"
            }
        }
    }
}
```
Notice that you can drop the dependencies on nfs and xdebug, you should also set a more secure password for your mysql server.

Source mounts
-------------

The project root directory is mounted inside the dev virtual machine directory under the /vagrant path when using both kitchen converge or vagrant up to launch the machine.


Todos
-----
- Expose an interface for creating source symlinks

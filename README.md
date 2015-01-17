drupal-env
==========

Drupal environment with Berkshelf Chef and Vagrant support

Note
----
At this point only the lamp environment is available


Requirements
------------
* chef-solo: tested on 11.8.2
* berkshelf: tested on 3.1.5

Extra development requirements
-----------------------------
* vagrant >= 1.5.2
* chef dk >= 0.2.0
* virtualbox: tested on 4.1.14
* vagrant-berkshelf (vagrant plugin install vagrant-berkshelf) - Optional, kitchen converge can be used to launch the vm instead of vagrant up

* Note: there is currently an issue with running provision a second time with vagrant-berkshelf 4.0.0. See https://github.com/berkshelf/vagrant-berkshelf/issues/237

Resources links
---------------
* Chef DK(includes Berkshelf): https://downloads.getchef.com/chef-dk/
* Vagrant: https://www.vagrantup.com/downloads.html
* Virtualbox: https://www.virtualbox.org/wiki/Downloads


How to test dev environment
---------------------------
- Clone the repository
- Go to the project root
- Run kitchen converge (or "vagrant up" if you wish to use vagrant-berkshelf)

Source mounts
-------------

The project root directory is mounted inside the dev virtual machine directory under the /vagrant path when using both kitchen converge or vagrant up to launch the machine.


Todos
-----
- Find/create drush cookbook
- Find/create drupal cookbook
- Update documentation

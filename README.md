drupal-env
==========

Drupal environment with Berkshelf Chef and Vagrant support
* Master: [![Build Status](https://api.travis-ci.org/sergiuionescu/drupal-env.svg?branch=master)](http://travis-ci.org/sergiuionescu/drupal-env)
* Dev: [![Build Status](https://api.travis-ci.org/sergiuionescu/drupal-env.svg?branch=dev)](http://travis-ci.org/sergiuionescu/drupal-env)

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
* vagrant-berkshelf (vagrant plugin install vagrant-berkshelf)
* chef dk >= 0.2.0
* virtualbox: tested on 4.1.14

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
- Run "vagrant up"


Todos
-----
- Find/create drush cookbook
- Find/create drupal cookbook
- Update documentation

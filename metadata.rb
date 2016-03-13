name             'drupal'
maintainer       'Sergiu Ionescu'
maintainer_email 'sergiu.ionescu@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures drupal'
long_description 'Installs/Configures drupal'
version          '1.0.0'
source_url       'https://github.com/sergiuionescu/drupal' if respond_to?(:source_url)
issues_url       'https://github.com/sergiuionescu/lamp/drupal' if respond_to?(:issues_url)

depends 'lamp'
depends 'drush'
depends 'mysql2_chef_gem'
depends 'database'

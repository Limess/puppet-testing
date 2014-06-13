# PRIVATE CLASS: do not call directly
class mongodb::server::install {
  $package_ensure = $mongodb::server::package_ensure
  $package_name   = $mongodb::server::package_name
  $version        = $mongodb::globals::version

  case $package_ensure {
    true:     {
      $my_package_ensure = 'present'
      $file_ensure     = 'directory'
    }
    false:    {
      $my_package_ensure = 'absent'
      $file_ensure     = 'absent'
    }
    'absent': {
      $my_package_ensure = 'absent'
      $file_ensure     = 'absent'
    }
    'purged': {
      $my_package_ensure = 'purged'
      $file_ensure     = 'absent'
    }
    default:  {
      $my_package_ensure = $package_ensure
      $file_ensure     = 'present'
    }
  }

  file { '/tmp/mongodb':
    ensure => 'directory',
    before => File['/tmp/mongodb/install-server.rpm', '/tmp/mongodb/install-base.rpm'],
  }

  file { '/tmp/mongodb/install-server.rpm':
    source => "puppet:///modules/mongodb/${package_name}.rpm",
    before => Package['mongodb-server'],
  }

  file { '/tmp/mongodb/install-base.rpm':
    source => "puppet:///modules/mongodb/mongodb-org-${version}.x86_64.rpm",
    before => Package['mongodb'],
  }

  package { 'mongodb':
    ensure   => $my_package_ensure,
    name     => "mongo-10gen-${version}-mongodb_1.x86_64",
    provider => rpm,
    source   => '/tmp/mongodb/install-base.rpm', 
  }
  ->
  package { 'mongodb-server':
    ensure   => $my_package_ensure,
    name     => "mongo-10gen-server-${version}-mongodb_1.x86_64",
    provider => rpm,
    source   => '/tmp/mongodb/install-server.rpm',
  }
}

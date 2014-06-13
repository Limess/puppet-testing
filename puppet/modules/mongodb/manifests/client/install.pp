# PRIVATE CLASS: do not call directly
class mongodb::client::install {
  $package_ensure = $mongodb::client::ensure
  $package_name   = $mongodb::client::package_name

  case $package_ensure {
    true:     {
      $my_package_ensure = 'present'
    }
    false:    {
      $my_package_ensure = 'purged'
    }
    'absent': {
      $my_package_ensure = 'purged'
    }
    default:  {
      $my_package_ensure = $package_ensure
    }
  }

  file { '/tmp/mongodb/install-client.rpm': 
    source => "puppet:///modules/mongodb/mongo-10gen-client-2.2.7-mongodb_1.x86_64.rpm",
    before => Package['mongodb_client'],
  }
 
  package { 'mongodb_client':
    ensure   => $my_package_ensure,
    name     => $package_name,
    provider => rpm,
    source   => "/tmp/mongodb/install-client.rpm",
  }
}

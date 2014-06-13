$gradle_home = '/opt/gradle'

class { 'java':
  distribution => 'jdk',
  version      => 'present',
}

class { 'gradle':
  version => '0.9.2',
  require => Class["java"],
}

file { ["/usr/local/mongodb/data", "/usr/local/mongodb"]:
  ensure => "directory",
  before => Class["::mongodb::server"],
}

class { '::mongodb::globals':
  version             => '2.2.7',
  server_package_name => 'mongodb-org-server-2.2.7.x86_64',
}
->
class { '::mongodb::server':
  port    => '27017',
  verbose => true,
  auth    => true,
  user    => 'vagrant',
  group   => 'vagrant',
#  dbpath  => "/usr/local/mongodb/data/db",
}

mongodb::db { 'TestDB':
  user     => 'root',
  password => 'pwd',
  require  => Class["::mongodb::server"],
}

service { "iptables":
  ensure   => false,
  provider => 'init',
}  
~>
class { '::tomcat':
  server_port => $server_port,
}
~>
tomcat::instance { 'A':
  server_port => '8082',
  http_port   => '8011',
  ajp_port    => '8046',
}

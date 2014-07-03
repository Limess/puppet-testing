class profiles::mongodb {
  include mongodb::server
  
  $tomcat_dbs = hiera('mongodb::dbs', {})
    create_resources('mongodb::dbs', $mongodb_dbs)

  file { ["/usr/local/mongodb/data", "/usr/local/mongodb"]:
    ensure => "directory",
    before => Class['::mongodb::server'],
  }
}

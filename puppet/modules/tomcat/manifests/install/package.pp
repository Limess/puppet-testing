class tomcat::install::package {
  package { "tomcat-${::tomcat::major_version}":
    ensure => present,
  }
}

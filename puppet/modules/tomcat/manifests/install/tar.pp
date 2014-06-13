class tomcat::install::tar {
  archive { "tomcat":
    ensure => 'present',
    source => "puppet:///modules/tomcat/apache-tomcat-${::tomcat::full_version}.tar.gz",
    target => '/usr/share',
  }

}

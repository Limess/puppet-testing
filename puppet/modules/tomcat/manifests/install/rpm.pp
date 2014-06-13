class tomcat::install::rpm {
  File {
    owner => $::tomcat::user,
    group => $::tomcat::group,
    mode  => 0644,
  }

  file { '/tmp/tomcat':
    ensure => 'directory',
    before => File['/tmp/tomcat/tomcat-install.rpm'],
  }

  file { '/tmp/tomcat/tomcat-install.rpm':
    ensure  => 'file',
    source  => "puppet:///modules/tomcat/apache-tomcat-${::tomcat::full_version}.rpm",
    replace => true,
    before  => Package['apache-tomcat'],
  }

  package { 'apache-tomcat':
    ensure   => 'installed',
    provider => rpm,
    source   => '/tmp/tomcat/tomcat-install.rpm',
  }
}

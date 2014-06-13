class tomcat::user {
  group { $::tomcat::group :
    ensure => present,
  } ->
  user { $::tomcat::user :
    ensure => present,
    groups => $::tomcat::group,
    home   => $::tomcat::base_dir,
  }
}

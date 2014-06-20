class tomcat (
  $version        = '7',
  $server_port    = '8081',
  $http_port      = '8010', 
  $ajp_port       = '8045',
  $install_source = 'rpm',
  $user           = 'tomcat',
  $group          = 'tomcat',
) {

  $full_version = $version? {
    5 => '5.5.36',
    6 => '6.0.41',
    7 => '7.0.26',
    8 => '8.0.8',
  }

  $base_dir = $install_source? {
    'package' => "/var/lib/tomcat${version}",
    'rpm'     => "/usr/share/apache-tomcat-${full_version}",
    'tar'     => "/usr/share/apache-tomcat-${full_version}",
  }

  validate_re("${version}", '^[5-8]$')
  validate_re("${server_port}", '^[0-9]+$')
  validate_re("${http_port}", '^[0-9]+$')
  validate_re("${ajp_port}", '^[0-9]+$')
  validate_re("${install_source}", ['rpm', 'tar', 'package'])

  class { 'tomcat::user': } ->
  class { 'tomcat::install': }
}

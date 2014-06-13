define tomcat::instance (
  $running     = true,
  $base_dir    = '/usr/share/tomcat',
  $user        = $::tomcat::user,
  $group       = $::tomcat::group,
  $http_port   = $::tomcat::http_port,
  $server_port = $::tomcat::server_port,
  $ajp_port    = $::tomcat::ajp_port,
) {

  Class['tomcat::install'] -> Tomcat::Instance[$title]

  validate_bool($running)
  validate_string($user)
  validate_string($group)
  validate_re("${http_port}", '^[0-9]+$')
  validate_re("${server_port}", '^[0-9]+$')
  validate_re("${ajp_port}", '^[0-9]+$')

  if $running == true {
    notice("Establishing http://${hostname}:${server_port}/")
  }

  if $title == 'default' {
    $instance_dir = $::tomcat::base_dir
    $service      = 'tomcat'
  } else {
    $instance_dir = "${base_dir}-${title}"
    $service      = "tomcat-${title}"
  }

  $catalina_base = $instance_dir

  file { "/etc/init.d/${service}":
    ensure  => 'file',
    content => template('tomcat/tomcat-init.erb'),
    notify  => Service[$service],
    owner   => 'root',
    group   => 'root',
    mode    => 0755,
  }

  unless $title == 'default' {    
  file { $instance_dir:
      ensure  => 'directory',
      source  => "puppet:///modules/tomcat/tomcat-service",
      recurse => true,
      force   => true,
      purge   => true,
      notify  => [File["${instance_dir}/conf/server.xml", 
                   "${instance_dir}/conf/tomcat-users.xml", 
                   "${instance_dir}/bin/setenv.sh"],
                   ::Tomcat::Instance::Permissions[$instance_dir]],
      owner   => $user,
      group   => $group,
      mode    => 0444,
    }
  }

  file { "${instance_dir}/conf/server.xml":
    ensure  => 'file',
    content => template('tomcat/server.xml.erb'), 
    notify  => Service[$service],
  }

  file { "${instance_dir}/conf/tomcat-users.xml":
    ensure  => 'file',
    content => template('tomcat/tomcat-users.xml.erb'),
    notify  => Service[$service],
  }

  file { "${instance_dir}/bin/setenv.sh":
    ensure  => 'file',
    content => template('tomcat/setenv.erb'),
    notify  => Service[$service],
  }

  ::tomcat::instance::permissions{ $instance_dir: }

  service { $service:
    ensure     => $running,
    enable     => true,
    hasstatus  => false,
    hasrestart => true,
    status     => "ps aux | grep org.apache.catalina.startup.Bootstrap | grep ${catalina_base}/bin/tomcat-juli.jar | grep -vci grep"
  }
}

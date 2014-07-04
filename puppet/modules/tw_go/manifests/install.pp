define tw_go::install(
  $role = $title,
  $version = '14.1.0',
  $build = '18882',
  $vnc = false,
  $daemon = true,
) {
  validate_re($title,'^(agent|server)$')
  validate_re($version, '^\d+\.\d+\.\d+$')
  validate_re($build, '^\d+$')
  validate_bool($vnc)
  validate_bool($daemon)

  $ext = $osfamily ? {
    'Solaris' => '-solaris.gz',
    'Debian'  => '.deb',
    'RedHat'  => '.noarch.rpm',
  }

  exec { 'download-installer':        
    command => "usr/bin/wget http://download01.thoughtworks.com/go/${version}/ga/go-${role}-${version}-${build}${ext} ",
    path    => '/usr/bin/wget',
    cwd     => '/var/tmp',
    creates => "/var/tmp/go-${role}-${version}-${build}${ext}",
  }

  package { 'install':
    ensure   => 'present',
    source   => "/var/tmp/go-${role}-${version}-${build}.${ext}",
    require  => Exec['download-installer'],
  }

  unless $role == $server {
    file { 'configuration':
      path    => '/etc/default/go-agent',
      content => template('tw_go/go_agent_configuration.erb'),
      owner   => $user,
      group   => $group,
      mode    => '444',
      notify  => Service['go-agent'],
    }
  }

  service {'go-agent':
    ensure  => 'running',
    require => Package['install'],
  }
}

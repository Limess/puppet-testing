class git::clone ($path, $repo) {
  package { 'git':
    ensure => installed,
  }

  exec { 'ssh know github':
    command => 'ssh -Tv git@github.com -o StrictHostKeyChecking=no; echo Success',
    path    => '/bin:/usr/bin',
    user    => 'vagrant',
  }
    
  vcsrepo { "variable_path":
    path     => "$path",
    ensure   => latest,
    owner    => vagrant,
    group    => vagrant,
    provider => git,
    require  => [ Package["git"], Exec['ssh know github']],
    source   => "${repo}",
    revision => 'master',
 }
}

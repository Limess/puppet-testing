define tomcat::instance::permissions (
  $instance_dir = $title,
  $owner        = $::tomcat::user,
  $group        = $::tomcat::group,
) {

  File {
    ensure  => 'directory',
    owner   => $owner,
    group   => $group,
    recurse => true,
    mode    => 0744,
  }

  file { "${instance_dir}/webapps": }

  file { "${instance_dir}/logs": }

  file { "${instance_dir}/temp": }

  file { "${instance_dir}/work": }
}

define tomcat::instance::permissions (
  $folder_presence = 'directory',
  $instance_dir    = $title,
  $owner           = $::tomcat::user,
  $group           = $::tomcat::group,
) {

  File {
    ensure  => $folder_presence,
    owner   => $owner,
    group   => $group,
    recurse => true,
    mode    => '0644',
  }

  file { "${instance_dir}/webapps": }

  file { "${instance_dir}/logs": }

  file { "${instance_dir}/temp": }

  file { "${instance_dir}/work": }

  file { "${instance_dir}/conf": }
}

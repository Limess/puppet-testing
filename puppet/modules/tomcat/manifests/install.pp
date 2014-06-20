# PRIVATE CLASS, DO NOT REFER TO DIRECTLY
class tomcat::install {
  $source       = $::tomcat::install_source
  $base_dir     = $::tomcat::base_dir

  File {
    owner => $::tomcat::user,
    group => $::tomcat::group,
    mode  => 0644,
  }
/*
  file { $base_dir:
    ensure  => 'directory',
    purge   => true
    recurse => true,
  }
*/
 
  class{ "::tomcat::install::${source}":
    #    require => File[$base_dir],
   }

  file { '/opt/tomcat':
    ensure  => 'link',
    target  => $base_dir,
    recurse => true,
    require => Class["::tomcat::install::${source}"],
    owner   => $::tomcat::user,
    group   => $::tomcat::user,
    mode    => 0744,
  }

  file { '/etc/environment':
    content => inline_template("CATALINA_HOME=/opt/tomcat"),
  }

}


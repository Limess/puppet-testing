class profiles::tomcat {
  $tomcat_instances = hiera('tomcat::instances', {})
  include tomcat
 
  create_resources('tomcat::instance', $tomcat_instances)
}

class profiles::firewall {
  $running

  service{ 'iptables':
    ensure => $running;
  }
}

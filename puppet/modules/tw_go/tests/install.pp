tw_go::install {'agent':
  version => '14.1.0', 
  build   => '18882', 
  vnc     => false, 
  daemon  => true, 
}
#  tw_go::install {'server':
#  version => '13.4.1', 
#  build   => '18342', 
#  vnc     => true, 
#  daemon  => false, 
#}
  

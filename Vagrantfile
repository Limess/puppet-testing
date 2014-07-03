# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box"
  config.vm.network :private_network, ip: "192.168.33.15"
  #config.vm.network "forwarded_port", guest: 8081, host: 8091, autocorrect: true
  #config.vm.network "forwarded_port", guest: 8082, host: 8092, autocorrect: true
  #config.vm.network "forwarded_port", guest: 8080, host: 8090, autocorrect: true
  #config.vm.network "forwarded_port", guest: 8090, host: 9000, autocorrect: true
  
  config.vm.hostname = "test.example.com"
  
  ## Enable SSH key forwarding from host -> guest
  config.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa']
  config.ssh.forward_agent = true
  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  # Vagrant VBGuest additions auto-update toggle
  config.vbguest.auto_update = false
  # Puppet Config
  config.vm.provision :puppet do |puppet|
    	puppet.manifests_path = "puppet/manifests"
    	puppet.manifest_file  = "site.pp"
	puppet.module_path = "puppet/modules"
        puppet.hiera_config_path = "puppet/hiera/hiera.yaml"
       # puppet.options = "--verbose --debug"
  end

end

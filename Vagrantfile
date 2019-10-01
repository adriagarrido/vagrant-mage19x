# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vagrant.plugins = ["vagrant-vbguest", "vagrant-disksize"]
  config.vm.box = "ubuntu/xenial64"
  config.disksize.size = "50GB"

  config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
      v.name = "vagrant-mage19x"
  end

  config.vm.network "private_network", ip: "192.168.33.10"

  APACHE_UID = 33
  APACHE_GID = 33
  config.vm.synced_folder "public/", "/var/www/html", owner:APACHE_UID, group:APACHE_GID

  config.vm.provision :shell, path: "scripts/initial_installation.sh"

end

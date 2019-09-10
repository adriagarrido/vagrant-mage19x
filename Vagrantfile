# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
      v.name = "Scharlab - Test"
  end

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.synced_folder "../", "/schartest"
  config.vm.synced_folder "../www/", "/var/www/html", owner:"www-data", group:"www-data"

  config.vm.provision :shell, path: "scripts/initial_installation.sh"

end

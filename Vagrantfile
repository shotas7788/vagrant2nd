# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  
  # [初回のみ]必要なパッケージのインストール等初期設定
  config.vm.provision :shell, :path => "provision/provision.sh"
end

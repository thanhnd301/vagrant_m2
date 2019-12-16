# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
$provision_script = "scripts/installer.sh"
CONFIG = File.join(File.dirname(__FILE__), "config.rb")
if File.exist?(CONFIG)
  require CONFIG
else
  puts "config.rb is missing"
  exit
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = $vm_box
  config.vm.box_url = $vm_box
  config.vm.hostname = $hostname
  config.ssh.insert_key = false  
  
  $vm_ips.each do |ip|
    puts "Private network ip: %s" % ip
    config.vm.network :private_network, ip: ip
  end
  config.vm.provider "virtualbox" do |vb|
      
  end
  config.vm.network :forwarded_port, guest: 22, host: $vm_ssh_port, auto_correct: false,  id: "ssh"
  #config.vm.synced_folder ".", "/vagrant", disabled: true

  INSTALLER = File.join(File.dirname(__FILE__), $provision_script)
  if File.exist?(INSTALLER)
    config.vm.provision :shell do |s|
        s.privileged = false
        s.path = $provision_script
        s.args = [$hostname]
    end
  end

  config.vm.provider :virtualbox do |vb|
    #unless File.exist?('./data.vdi')
    #  vb.customize ['createhd', '--filename', './data.vdi', '--variant', 'Fixed', '--size', 100 * 1024]
    #end

    vb.customize ["modifyvm", :id, "--memory", $vm_memory]
    vb.customize ["modifyvm", :id, "--name", $vm_name]
    vb.customize ["modifyvm", :id, "--cpus", $vm_cpus]
	  vb.customize ["modifyvm", :id, "--vram", 16]
	  vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    #vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', './data.vdi']
    #vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", "0", "--device", "1", "--type", "dvddrive", "--medium", "emptydrive"]
    
    # Disable USB 2.0 support since it cause error
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
    
    # For debugging
    if $gui
        vb.gui = true
    end
  end
  
  config.ssh.forward_agent = true
end
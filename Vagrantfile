# -*- mode: ruby -*-

# This function sets the VM's name in Virtualbox properly
# so it's easy to see what project the VMs refer to.
def set_vm_project_name(machine, hostname)
  machine.vm.hostname = "#{hostname}.local"
  machine.vm.provider :virtualbox do |virtualbox|
    virtualbox.name = "mytest-#{hostname}"
  end
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.provider :virtualbox do |v|
    v.gui = false
    v.cpus = 2
    v.memory = 256
    v.linked_clone = true

    v.customize ["modifyvm", :id, "--pae",    "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.define "controller" do |m|
    set_vm_project_name(m, "controller")
    m.vm.box = "geerlingguy/debian10"
    m.vm.network :private_network, ip: "179.168.86.10"

    m.vm.synced_folder "./", "/home/vagrant/code",
      owner: "vagrant", group: "vagrant",
      mount_options: ["dmode=755", "fmode=644"]
  end

  config.vm.define "webserver1" do |m|
    set_vm_project_name(m, "webserver1")
    m.vm.box = "geerlingguy/debian10"
    m.vm.network :private_network, ip: "179.168.86.20"
    m.vm.network :forwarded_port, guest: 80, host: 8080, protocol: "tcp"
  end

  config.vm.define "dbserver1" do |m|
    set_vm_project_name(m, "dbserver1")
    m.vm.box = "geerlingguy/debian10"
    m.vm.network :private_network, ip: "179.168.86.21"
    m.vm.network :forwarded_port, guest: 5432, host: 5432, protocol: "tcp"
  end
end

# vim: set ts=2 sw=2 et ft=ruby #

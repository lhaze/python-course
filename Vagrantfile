# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
require 'rbconfig'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.box_url = "https://vagrantcloud.com/ubuntu/boxes/bionic64"
    config.vm.synced_folder ".", "/vagrant"
    config.vm.provider "virtualbox" do |vb|
        vb.name = "python_course"
    end

    config.vm.network "forwarded_port", guest: 5000, host: 8000
    config.vm.network "public_network"
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    # Setting up private_network to have virtual host
    # config.vm.network :private_network, ip: "192.168.33.10"
    # config.ssh.forward_agent = true

    # config.vm.provision "fix-no-tty", type: "shell" do |s|
    #     s.privileged = true
    #     s.inline = "sed -i '/tty/!s/mesg n/tty -s \&\& mesg n \|\| true/' /r$ end
    # end

    is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
    if is_windows
        # provisioning with shell script (and local Ansible within VM)
        config.vm.provision "shell", :path => "devops/install_ansible.sh"
        config.vm.provision "shell" do |sh|
            sh.path = "devops/provision_locally.sh"
            sh.args = "devops/setup_playbook.yml"
        end
    else
        # provisioning with Ansible through SSH.
        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "devops/setup_playbook.yml"
            ansible.inventory_path = "python_course,"
            ansible.sudo = true
        end
    end
end

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.box_version = "1905.1"

# Use following setting to specify custom ssh keys
#  config.ssh.insert_key = false
#  config.ssh.private_key_path = ["~/.ssh/k8s","~/.vagrant.d/insecure_private_key"]
#  config.vm.provision "file", source: "~/.ssh/k8s.pub", destination: "~/.ssh/authorized_keys"

  config.vm.provider :virtualbox do |v|
    v.memory = 2048
    v.cpus = 2
  end

  %w{admin}.each_with_index do |name, i|
    config.vm.define name do |admin|
      admin.vm.box = "centos/7"
      admin.vm.hostname = name
      admin.vm.provider :virtualbox do |v|
        v.name = name
        v.memory = 1024
        v.cpus = 2
      end
      admin.vm.network :private_network, ip: "172.24.20.10"
      admin.vm.provision "shell", path: 'scripts/install-base'
      admin.vm.provision "shell", path: 'scripts/install-admin'
      admin.vm.provision "shell", path: 'scripts/tools/setup-nfs-server'
    end
  end

  %w{master}.each_with_index do |name, i|
    config.vm.define name do |master|
      master.vm.box = "centos/7"
      master.vm.hostname = name
      master.vm.provider :virtualbox do |v|
        v.name = name
      end
      master.vm.network :private_network, ip: "172.24.20.11"
      master.vm.provision "shell", path: 'scripts/install-base'
      master.vm.provision "shell", path: 'scripts/install-k8s-common'
      master.vm.provision "shell", path: 'scripts/install-k8s-master'
      master.vm.provision "shell", path: 'scripts/tools/setup-helm'
      master.vm.provision "shell", path: 'scripts/tools/setup-nfs-client-provision'
    end
  end

  %w{node1 node2}.each_with_index do |name, i|
    config.vm.define name do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = name
      node.vm.provider :virtualbox do |v|
        v.name = name
        v.memory = 25600
        v.cpus = 6 
      end
      node.vm.network :private_network, ip: "172.24.20.#{i + 21}"
      # Forward port on node1 30443 for ingress.
      if name == 'node1'
        node.vm.network "forwarded_port", guest: 30080, host: 30080
        node.vm.network "forwarded_port", guest: 30443, host: 30443
      end

      node.vm.provision "shell", path: 'scripts/install-base'
      node.vm.provision "shell", path: 'scripts/install-k8s-common'
      node.vm.provision "shell", path: 'scripts/install-k8s-node'

    end
  end

end

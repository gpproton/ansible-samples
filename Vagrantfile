nodes = [
  { :hostname => 'virt-00', :ip => '10.10.0.10', :box => 'generic/debian11', :ram => 512 },
  { :hostname => 'virt-01',  :ip => '10.10.0.20', :box => 'generic/debian11', :ram => 512 }
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = "generic/debian11"
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      nodeconfig.vm.network :private_network, ip: node[:ip]

      memory = node[:ram] ? node[:ram] : 256;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
        ]
      end
    end
  end
end
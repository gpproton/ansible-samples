defaultBox = 'generic/alma9'
nodes = [
  { :hostname => 'virt-00', :ip => '10.10.0.10', :box => defaultBox, :ram => 512 },
  { :hostname => 'virt-01',  :ip => '10.10.0.20', :box => defaultBox, :ram => 512 },
  # { :hostname => 'win-00',  :ip => '10.10.0.30', :box => 'peru/windows-10-enterprise-x64-eval', :ram => 2048 }
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box] ? node[:box] : defaultBox
      nodeconfig.vm.hostname = node[:hostname] + ".sv.test"
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
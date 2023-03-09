default_box = 'generic/alma9'
timeout = 1200
nodes = [
  { :hostname => 'virt-00', :ip => '10.10.0.10', :box => default_box, :ram => 512, :cpus => 1 },
  { :hostname => 'virt-01',  :ip => '10.10.0.20', :box => default_box, :ram => 512, :cpus => 1 },
  { :hostname => 'virt-02',  :ip => '10.10.0.30', :box => default_box, :ram => 512, :cpus => 1 },
  # { :hostname => 'win-00',  :ip => '10.10.0.40', :box => 'jborean93/WindowsServer2022', :ram => 3072 , :cpus => 2 }
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.boot_timeout = timeout
      nodeconfig.vm.box = node[:box] ? node[:box] : default_box
      nodeconfig.vm.hostname = node[:hostname] + ".sv.easy"
      nodeconfig.vm.network :private_network, ip: node[:ip]
      nodeconfig.vm.provider :libvirt do |vb|
        vb.memory = node[:ram]
        vb.cpus = node[:cpus]
      end
      memory = node[:ram]
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.name = node[:hostname]
        vb.linked_clone = true
        vb.memory = node[:ram]
        vb.cpus = node[:cpus]
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
        ]
      end
      ## Copy initilization script
      nodeconfig.vm.provision :file do |file|
        file.source = ".secret/password.txt"
        file.destination = "/tmp/password.txt"
      end
      ## Copy vagrant password file
      nodeconfig.vm.provision :file do |file|
        file.source = "scripts/_vagrant_init.sh"
        file.destination = "/tmp/init.sh"
      end
      nodeconfig.vm.provision :shell, inline: <<-SHELL
        . /tmp/init.sh
        vg_run_all
      SHELL
    end
  end
end
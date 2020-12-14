# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vbguest.auto_update = true
  config.vbguest.no_remote = true
  config.ssh.insert_key = true
  config.ssh.forward_agent = true

  # First clients that build themselves from the repo of their domain
  # TODO read this from data/*:dev/*.yaml
  {
      # 'dev.systarch.com'  => { :cpus => 2, :ip => '172.31.31.10', :memory => 4096 },
      'repo.dev.systarch.com' => { :cpus => 4, :ip => '172.30.30.3', :memory => 8192 },
      'gitlab.dev.systarch.com'  => { :cpus => 2, :ip => '172.30.30.6', :memory => 4096 },
  }.each do |hostname, parameters|
    config.vm.define hostname do |cfg|
      config.vm.box = "systarch/debian10"
      config.vm.box_url = "https://repo.systarch.com/debian10/virtualbox.json"
      cfg.vm.provider :virtualbox do |vb, override|

        cfg.ssh.forward_agent = true

        override.vm.hostname = hostname
        vb.name = hostname

        vb.customize [
                         "modifyvm", :id,
                         "--memory", parameters[:memory],
                         "--cpus", parameters[:cpus],
                         "--hwvirtex", "on",
                         "--natdnshostresolver1", "on"
                     ]

        config.vm.network "private_network",
                          :type => 'static',
                          :ip => parameters[:ip],
                          :adapter => 2

        override.vm.synced_folder ".", "/home/vagrant/src", type: "virtualbox"

        # gitlab specific synced folder mounts
        case hostname
        when "gitlab.dev.systarch.com"
          override.vm.synced_folder "backups/gitlab.dev.systarch.com/var.opt.gitlab.backups", "/var/opt/gitlab/backups", create: true, mount_options: ["uid=995,gid=995"]
          override.vm.synced_folder "backups/gitlab.dev.systarch.com/etc.gitlab", "/etc/gitlab", create: true, mount_options: ["uid=0,gid=0"]
        else
          # type code here
        end
        # Package caching ersetzt die (eventuell nicht vorhandene oder nicht mehr verfügbare) package registry
        # on ubuntu 20.04: uid=105(_apt) gid=65534(nogroup)
        override.vm.synced_folder "backups/#{hostname}/var.cache.apt", "/var/cache/apt", create: true, mount_options: ["uid=105,gid=65534"]
        override.vm.synced_folder "dist", "/dist", create: true

        override.vm.provision :shell,
                              :name => 'install /dist/systemconfig.deb provided by host',
                              :path => 'src/vagrant/000-install-systemconfig-from-dist.bash',
                              :privileged => true,
                              :run => "always"
        override.vm.provision "shell",
                              name: "Apply puppet recipes for #{hostname}",
                              inline: "systemconfig-apply",
                              :privileged => false,
                              :run => "always"
      end
    end
  end

end

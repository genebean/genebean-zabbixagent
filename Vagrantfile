# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "genebean/centos-7-rvm-221"

  config.vm.provision "shell", inline: "yum -y install git"
  config.vm.provision "shell", inline: "gem install --no-ri --no-rdoc bundler"
  config.vm.provision "shell", inline: "su - vagrant -c 'rsync -rv --delete /vagrant/ /home/vagrant/zabbixagent --exclude bundle; cd /home/vagrant/zabbixagent; bundle install --jobs=3 --retry=3 --path=${BUNDLE_PATH:-vendor/bundle}'"

end

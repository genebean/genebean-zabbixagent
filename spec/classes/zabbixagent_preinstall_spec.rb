require 'spec_helper'

describe 'zabbixagent::preinstall' do

  # Running an RedHat OS.
  context 'On a RedHat OS with repo management enabled' do
    let :facts do
      {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '7'
      }
    end

    let :pre_condition do
      "class {'zabbixagent':
        manage_repo_zabbix => true,
        manage_repo_epel   => true,
      }"
    end

    it 'should create zabbix.repo' do
      should contain_file('/etc/yum.repos.d/zabbix.repo').with_content(/baseurl=http:\/\/repo.zabbix.com\/zabbix\/2.4\/rhel\/7\/\$basearch\//)
    end

    it 'should create epel.repo' do
      should contain_file('/etc/yum.repos.d/epel.repo').with_content(/mirrorlist=https:\/\/mirrors.fedoraproject.org\/.*epel-7/)
    end

  end

  # Running an SLES OS.
  context 'On a SLES 12.1 OS with repo management enabled' do
    let :facts do
      {
          :kernel                 => 'Linux',
          :osfamily               => 'Suse',
          :operatingsystem        => 'SLES',
          :operatingsystemrelease => '12.1'
      }
    end

    let :pre_condition do
      "class {'zabbixagent':
        manage_repo_zabbix => true,
      }"
    end

    it 'should create server_monitoring.repo' do
      should contain_file('/etc/zypp/repos.d/server_monitoring.repo').with_content(/baseurl=http:\/\/download.opensuse.org\/repositories\/server:\/monitoring\/SLE_12_SP1\//)
    end
  end

  context 'On a SLES 11.3 OS with repo management enabled' do
    let :facts do
      {
          :kernel                 => 'Linux',
          :osfamily               => 'Suse',
          :operatingsystem        => 'SLES',
          :operatingsystemrelease => '11.2'
      }
    end

    let :pre_condition do
      "class {'zabbixagent':
        manage_repo_zabbix => true,
      }"
    end

    it 'should raise error' do
      should raise_error(/SLES 11.2 is not supported/)
    end
  end

end

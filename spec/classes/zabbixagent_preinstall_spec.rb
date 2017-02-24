require 'spec_helper'

describe 'zabbixagent::preinstall' do

  # Running an RedHat 7.
  context 'On a RedHat 7 with repo management enabled' do
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
        version            => '3.2',
      }"
    end

    it 'should create zabbix.repo' do
      should contain_file('/etc/yum.repos.d/zabbix.repo').with_content(/baseurl=http:\/\/repo.zabbix.com\/zabbix\/3.2\/rhel\/7\/\$basearch\//)
      should contain_file('/etc/yum.repos.d/zabbix.repo').with_content(/gpgkey=http:\/\/repo.zabbix.com\/RPM-GPG-KEY-ZABBIX-A14FE591/)
    end

    it 'should create epel.repo' do
      should contain_file('/etc/yum.repos.d/epel.repo').with_content(/mirrorlist=https:\/\/mirrors.fedoraproject.org\/.*epel-7/)
    end

  end

  # Running an RedHat 5.
  context 'On a RedHat 5 with repo management enabled' do
    let :facts do
      {
          :kernel                    => 'Linux',
          :osfamily                  => 'RedHat',
          :operatingsystem           => 'RedHat',
          :operatingsystemmajrelease => '5'
      }
    end

    let :pre_condition do
      "class {'zabbixagent':
        manage_repo_zabbix => true,
        manage_repo_epel   => true,
        version            => '3.2',
      }"
    end

    it 'should create zabbix.repo' do
      should contain_file('/etc/yum.repos.d/zabbix.repo').with_content(/baseurl=http:\/\/repo.zabbix.com\/zabbix\/3.2\/rhel\/5\/\$basearch\//)
      should contain_file('/etc/yum.repos.d/zabbix.repo').with_content(/gpgkey=http:\/\/repo.zabbix.com\/RPM-GPG-KEY-ZABBIX-A14FE591-EL5/)
    end

    it 'should create epel.repo' do
      should contain_file('/etc/yum.repos.d/epel.repo').with_content(/mirrorlist=https:\/\/mirrors.fedoraproject.org\/.*epel-5/)
    end

  end

  # Running an Ubuntu 14.04.
  context 'On a Ubuntu 14 with repo management enabled' do
    let :facts do
      {
          :kernel                    => 'Linux',
          :osfamily                  => 'Debian',
          :operatingsystem           => 'Ubuntu',
          :lsbdistcodename           => 'trusty',
          :operatingsystemmajrelease => '14.04'
      }
    end

    let :pre_condition do
      "class {'zabbixagent':
        manage_repo_zabbix => true,
        version            => '3.2',
      }"
    end

    it 'should create zabbix.list' do
      should contain_file('/etc/apt/sources.list.d/zabbix.list').with_content(/deb http:\/\/repo.zabbix.com\/zabbix\/3.2\/ubuntu trusty main/)
    end
  end

  # Running an OpenSuSE OS.
  context 'On a OpenSuSE Leap 42.1 with repo management enabled' do
    let :facts do
      {
          :kernel                 => 'Linux',
          :osfamily               => 'Suse',
          :operatingsystem        => 'OpenSuSE',
          :operatingsystemrelease => '42.1'
      }
    end

    let :pre_condition do
      "class {'zabbixagent':
        manage_repo_zabbix => true,
      }"
    end

    it 'should create server_monitoring.repo' do
      should contain_file('/etc/zypp/repos.d/server_monitoring.repo').with_content(/baseurl=http:\/\/download.opensuse.org\/repositories\/home:\/ecsos:\/monitoring\/openSUSE_Leap_42.1\//)
    end
  end

  # Running an SLES OS.
  context 'On a SLES 12.1 with repo management enabled' do
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
        version            => '3.2',
      }"
    end

    it 'should create server_monitoring.repo' do
      should contain_file('/etc/zypp/repos.d/server_monitoring.repo').with_content(/baseurl=http:\/\/download.opensuse.org\/repositories\/home:\/ecsos:\/monitoring\/openSUSE_Leap_42.2\//)
    end
  end

  context 'On a SLES 11.3 with repo management enabled' do
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

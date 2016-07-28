require 'spec_helper'

describe 'zabbixagent::config' do

  describe 'with server and server_active params set' do
    let :facts do
      {
        :kernel          => 'Linux',
        :osfamily        => 'RedHat',
        :operatingsystem => 'RedHat',
        :fqdn            => 'SOMEHOST.example.com'
      }
    end

    context 'to a single server' do
      let :pre_condition do
        "class {'zabbixagent':
          server        => 'zabbix.example.com',
          server_active => 'zabbix.example.com',
        }"
      end

      it 'should set Server and ServerActive' do
        should contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(/Server=zabbix.example.com/)
        should contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(/ServerActive=zabbix.example.com/)
        should contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(/Hostname=somehost.example.com/)
      end
    end

    context 'to an array of servers' do
      let :pre_condition do
        "class {'zabbixagent':
          server        => ['zabbix.example.com', 'node.example.com'],
          server_active => ['zabbix.example.com', 'node.example.com'],
        }"
      end

      it 'should set Servers and ServersActive' do
        should contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(/Server=zabbix.example.com,node.example.com/)
        should contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(/ServerActive=zabbix.example.com,node.example.com/)
        should contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(/Hostname=somehost.example.com/)
      end
    end

  end

  describe 'with server params set on SLES' do
    let :facts do
      {
        :kernel                 => 'Linux',
        :osfamily               => 'Suse',
        :operatingsystem        => 'SLES',
        :operatingsystemrelease => '12.1',
        :fqdn                   => 'SOMEHOST.example.com'
      }
    end

    context 'to a single server' do
      let :pre_condition do
        "class {'zabbixagent':
          server        => 'zabbix.example.com',
          server_active => 'zabbix.example.com',
        }"
      end

      it 'should set Server and Hostname' do
        should contain_file('/etc/zabbix/zabbix-agentd.conf').with_content(/Server=zabbix.example.com/)
        should contain_file('/etc/zabbix/zabbix-agentd.conf').with_content(/Hostname=somehost.example.com/)
      end
    end

  end

  describe 'with config_dir set' do
    context 'on Linux' do
      let :facts do
        {
            :kernel          => 'Linux',
            :osfamily        => 'RedHat',
            :operatingsystem => 'RedHat'
        }
      end

      let :pre_condition do
        "class { 'zabbixagent':
        config_dir   => '/usr/local/etc/zabbix',
      }"
      end

      it "should write the config to /usr/local/etc/zabbix/" do
        should contain_file('/usr/local/etc/zabbix/zabbix_agentd.conf')
      end
    end

    context 'on Windows' do
      let :facts do
        {
            :kernel          => 'windows',
            :osfamily        => 'windows',
            :operatingsystem => 'windows'
        }
      end

      let :pre_condition do
        "class { 'zabbixagent':
        config_dir   => 'C:/ProgramData/zabbix',
      }"
      end

      it "should write the config to C:/ProgramData/zabbix/" do
        should contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf')
      end
    end
  end
end

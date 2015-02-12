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
end

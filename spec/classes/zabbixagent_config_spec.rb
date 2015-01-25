require 'spec_helper'

describe 'zabbixagent::config' do

  describe 'with server and server_active params set' do
    let :facts do
      {
        :kernel          => 'Linux',
        :osfamily        => 'RedHat',
        :operatingsystem => 'RedHat'
      }
    end

    context 'to a single server' do
      let :pre_condition do
        "class {'zabbixagent':
          servers        => 'zabbix.example.com',
          servers_active => 'zabbix.example.com',
        }"
      end

      it 'should set Servers and ServersActive' do
        should contain_ini_setting('servers setting').with_value('zabbix.example.com')
        should contain_ini_setting('servers active setting').with_value('zabbix.example.com')
      end
    end

    context 'to an array of servers' do
      let :pre_condition do
        "class {'zabbixagent':
          servers        => ['zabbix.example.com', 'node.example.com'],
          servers_active => ['zabbix.example.com', 'node.example.com'],
        }"
      end

      it 'should set Servers and ServersActive' do
        should contain_ini_setting('servers setting').with_value('zabbix.example.com,node.example.com')
        should contain_ini_setting('servers active setting').with_value('zabbix.example.com,node.example.com')
      end
    end

  end
end

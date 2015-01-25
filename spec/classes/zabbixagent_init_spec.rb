require 'spec_helper'

describe 'zabbixagent' do

  context 'On a RedHat OS with repo management enabled' do
    let :facts do
      {
          :kernel          => 'Linux',
          :osfamily        => 'RedHat',
          :operatingsystem => 'RedHat'
      }
    end

    let(:params) {
      {
          :manage_repo_epel   => true,
          :manage_repo_zabbix => true
      }
    }

    # Check that all classes are present
    it { should contain_class('zabbixagent::params')}
    it { should contain_class('zabbixagent::preinstall')}
    it { should contain_class('zabbixagent::install')}
    it { should contain_class('zabbixagent::config')}
    it { should contain_class('zabbixagent::service')}

  end

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

      it 'should pass parameters to zabbixagent::config' do
        should contain_class('zabbixagent::config').with(
          'servers'        => 'zabbix.example.com',
          'servers_active' => 'zabbix.example.com',
        )
      end
    end

    context 'to an array of servers' do
      let :pre_condition do
        "class {'zabbixagent':
          servers        => ['zabbix.example.com', 'node.example.com'],
          servers_active => ['zabbix.example.com', 'node.example.com'],
        }"
      end

      it 'should pass parameters to zabbixagent::config' do
        should contain_class('zabbixagent::config').with(
          'servers'        => '["zabbix.example.com", "node.example.com"]',
          'servers_active' => '["zabbix.example.com", "node.example.com"]',
        )
      end
    end

  end
end

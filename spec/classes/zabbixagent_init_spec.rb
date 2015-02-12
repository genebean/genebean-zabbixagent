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
          server        => 'zabbix.example.com',
          server_active => 'zabbix.example.com',
        }"
      end

      it 'should pass parameters to zabbixagent::config' do
        should contain_class('zabbixagent::config').with(
          'server'        => 'zabbix.example.com',
          'server_active' => 'zabbix.example.com',
        )
      end
    end

    context 'to an array of servers' do
      let :pre_condition do
        "class {'zabbixagent':
          server        => ['zabbix.example.com', 'node.example.com'],
          server_active => ['zabbix.example.com', 'node.example.com'],
        }"
      end

      it 'should pass parameters to zabbixagent::config' do
        should contain_class('zabbixagent::config').with(
          'server'        => '["zabbix.example.com", "node.example.com"]',
          'server_active' => '["zabbix.example.com", "node.example.com"]',
        )
      end
    end

  end
  
  describe 'post v2.1.0' do
    let :facts do
      {
        :kernel          => 'Linux',
        :osfamily        => 'RedHat',
        :operatingsystem => 'RedHat'
      }
    end
    
    context 'with include_dir set' do
      let :pre_condition do
        "class {'zabbixagent':
          include_dir => 'zabbix_agent.d',
        }"
      end
      
      it 'should raise error' do
        expect { 
          should compile
        }.to raise_error(/include_dir was removed in v2.1. Please update/)
      end
    end
    
    context 'with include_file set' do
      let :pre_condition do
        "class {'zabbixagent':
          include_file => 'bar',
        }"
      end
      
      it 'should raise error' do
        expect { 
          should compile
        }.to raise_error(/include_file was removed in v2.1. Please update/)
      end
    end
    
    context 'with logfile set' do
      let :pre_condition do
        "class {'zabbixagent':
          logfile => 'somefile',
        }"
      end
      
      it 'should raise error' do
        expect { 
          should compile
        }.to raise_error(/logfile was removed in v2.1. Please update/)
      end
    end
    
    context 'with servers set' do
      let :pre_condition do
        "class {'zabbixagent':
          servers => 'bar',
        }"
      end
      
      it 'should raise error' do
        expect { 
          should compile
        }.to raise_error(/servers was removed in v2.1. Please update/)
      end
    end
    
    context 'with servers_active set' do
      let :pre_condition do
        "class {'zabbixagent':
          servers_active => 'bar',
        }"
      end
      
      it 'should raise error' do
        expect { 
          should compile
        }.to raise_error(/servers_active was removed in v2.1. Please update/)
      end
    end
    
  end
end

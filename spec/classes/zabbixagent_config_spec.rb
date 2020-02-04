require 'spec_helper'

describe 'zabbixagent::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:node) { 'SOMEHOST.example.com' }
      let(:facts) { os_facts }

      context 'with server and server_active params set' do
        context 'to a single server' do
          let :pre_condition do
            "class {'zabbixagent':
              server        => 'zabbix.example.com',
              server_active => 'zabbix.example.com',
            }"
          end

          case os_facts[:kernel]
          when 'Linux'
            it 'sets Server and ServerActive when the kernel is "Linux"' do
              is_expected.to contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(%r{Server=zabbix.example.com})
              is_expected.to contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(%r{ServerActive=zabbix.example.com})
              is_expected.to contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(%r{Hostname=somehost.example.com})
            end
          when 'windows'
            it 'sets Server and ServerActive when the kernel is "windows"' do
              is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf').with_content(%r{Server=zabbix.example.com})
              is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf').with_content(%r{ServerActive=zabbix.example.com})
              is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf').with_content(%r{Hostname=somehost.example.com})
            end
          end
        end # end single server

        context 'to an array of servers' do
          let :pre_condition do
            "class {'zabbixagent':
              server        => ['zabbix.example.com', 'node.example.com'],
              server_active => ['zabbix.example.com', 'node.example.com'],
            }"
          end

          case os_facts[:kernel]
          when 'Linux'
            it 'sets Servers and ServersActive when the kernel is "Linux"' do
              is_expected.to contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(%r{Server=zabbix.example.com,node.example.com})
              is_expected.to contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(%r{ServerActive=zabbix.example.com,node.example.com})
              is_expected.to contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(%r{Hostname=somehost.example.com})
            end
          when 'windows'
            it 'sets Servers and ServersActive when the kernel is "windows"' do
              is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf').with_content(%r{Server=zabbix.example.com,node.example.com})
              is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf').with_content(%r{ServerActive=zabbix.example.com,node.example.com})
              is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf').with_content(%r{Hostname=somehost.example.com})
            end
          end
        end
      end # end with server and server_active params set

      context 'with config_dir set' do
        case os_facts[:kernel]
        when 'Linux'
          let :pre_condition do
            "class { 'zabbixagent':
              config_dir   => '/usr/local/etc/zabbix',
            }"
          end

          it 'writes the config to /usr/local/etc/zabbix/' do
            is_expected.to contain_file('/usr/local/etc/zabbix/zabbix_agentd.conf')
          end
        when 'windows'
          let :pre_condition do
            "class { 'zabbixagent':
              config_dir   => 'C:/ProgramData/zabbix',
            }"
          end

          it 'writes the config to C:/ProgramData/zabbix/' do
            is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf')
          end
        end # case
      end # with config_dir set
    end # on #{os}
  end # on_supported_os.each do |os, os_facts|
end # 'zabbixagent::config'

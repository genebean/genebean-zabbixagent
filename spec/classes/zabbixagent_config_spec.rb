require 'spec_helper'

describe 'zabbixagent::config' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:node) { 'SOMEHOST.example.com' }
      before(:each) do
        case facts[:os]['family']
        when 'Suse'
          @configdir  = '/etc/zabbix'
          @configfile = 'zabbix-agentd.conf'
          @custompath = '/usr/local/etc/zabbix'
        when 'windows'
          @configdir  = 'C:/ProgramData/zabbix'
          @configfile = 'zabbix_agentd.conf'
          @custompath = 'C:/custompath/zabbix'
        else
          @configdir  = '/etc/zabbix'
          @configfile = 'zabbix_agentd.conf'
          @custompath = '/usr/local/etc/zabbix'
        end
      end

      context 'with config_dir set' do
        let :pre_condition do
          "class { 'zabbixagent':
          config_dir   => '#{@custompath}',
        }"
        end

        it {should contain_file("#{@custompath}/#{@configfile}")}
      end

      describe 'with server and server_active params set' do
        context 'to a single server' do
          let :pre_condition do
            "class {'zabbixagent':
              server        => 'zabbix.example.com',
              server_active => 'zabbix.example.com',
            }"
          end

          it 'should set Server and ServerActive' do
            should contain_file("#{@configdir}/#{@configfile}").with_content(/Server=zabbix.example.com/)
            should contain_file("#{@configdir}/#{@configfile}").with_content(/ServerActive=zabbix.example.com/)
            should contain_file("#{@configdir}/#{@configfile}").with_content(/Hostname=somehost.example.com/)
          end
        end # ends context 'to a single server'

        context 'to an array of servers' do
          let :pre_condition do
            "class {'zabbixagent':
              server        => ['zabbix.example.com', 'node.example.com'],
              server_active => ['zabbix.example.com', 'node.example.com'],
            }"
          end

          it 'should set Servers and ServersActive' do
            should contain_file("#{@configdir}/#{@configfile}").with_content(/Server=zabbix.example.com,node.example.com/)
            should contain_file("#{@configdir}/#{@configfile}").with_content(/ServerActive=zabbix.example.com,node.example.com/)
            should contain_file("#{@configdir}/#{@configfile}").with_content(/Hostname=somehost.example.com/)
          end
        end # ends context 'to an array of servers'
      end # ends describe 'with server and server_active params set'
    end
  end
end

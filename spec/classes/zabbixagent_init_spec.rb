require 'spec_helper'

describe 'zabbixagent' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      before(:each) do
        case facts[:os]['family']
        when 'Suse'
          @configdir   = '/etc/zabbix'
          @configfile  = 'zabbix-agentd.conf'
          @includesdir = 'C:/ProgramData/zabbix/conf.d'
        when 'windows'
          @configdir   = 'C:/ProgramData/zabbix'
          @configfile  = 'zabbix_agentd.conf'
          @includesdir = 'C:/ProgramData/zabbix/conf.d'
        else
          @configdir   = '/etc/zabbix'
          @configfile  = 'zabbix_agentd.conf'
          @includesdir = '/etc/zabbix_agentd.conf.d'
        end
      end

      # Check that all classes are present
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('zabbixagent') }
      it { is_expected.to contain_class('zabbixagent::preinstall') }
      it { is_expected.to contain_class('zabbixagent::install') }
      it { is_expected.to contain_class('zabbixagent::config') }
      it { is_expected.to contain_class('zabbixagent::service') }

      context 'with manage_repo_zabbix => true' do
        let :pre_condition do
          "class {'zabbixagent':
            manage_repo_zabbix => true,
          }"
        end

        case facts[:os]['family']
        when 'Suse'
          it { is_expected.to raise_error(/Repository managment for the SUSE family is disabled/) }
        else
          it { is_expected.to compile.with_all_deps }
        end
      end # ends context 'with manage_repo_zabbix => true'

      describe 'with server and server_active params set' do
        context 'to a single server' do
          let :pre_condition do
            "class {'zabbixagent':
              server        => 'zabbix.example.com',
              server_active => 'zabbix.example.com',
            }"
          end

          it 'should pass parameters to zabbixagent' do
            is_expected.to contain_class('zabbixagent').with(
              'server'        => 'zabbix.example.com',
              'server_active' => 'zabbix.example.com',
            )
          end
        end # ends context 'to a single server'

        context 'to an array of servers' do
          let :pre_condition do
            "class {'zabbixagent':
              server        => ['zabbix.example.com', 'node.example.com'],
              server_active => ['zabbix.example.com', 'node.example.com'],
            }"
          end

          it 'should pass parameters to zabbixagent' do
            is_expected.to contain_class('zabbixagent').with(
              'server'        => '["zabbix.example.com", "node.example.com"]',
              'server_active' => '["zabbix.example.com", "node.example.com"]',
            )
          end
        end # ends context 'to an array of servers'
      end # ends describe 'with server and server_active params set'

      context 'with custom require settings' do
        let :pre_condition do
          "include ::stdlib

          class { 'zabbixagent':
            custom_require_linux   => Class['stdlib'],
            custom_require_windows => Class['stdlib'],
          }"
        end

        it 'should require => Class[Stdlib]' do
          is_expected.to contain_package('zabbix-agent').that_requires('Class[Stdlib]')
        end
      end # ends context 'with custom require settings'

      describe 'with exmaple settings from README.md' do
        let :pre_condition do
          "class { 'zabbixagent':
            ensure_setting => 'latest',
            include_files  => ['#{@includesdir}/userparams.conf',],
            log_file_size  => 0,
            server         => 'zabbix.example.com,offsite.example.com',
            server_active  => ['zabbix.example.com', 'offiste.example.com',],
          }"
        end

        it 'should ensure => latest' do
          is_expected.to contain_package('zabbix-agent').with_ensure('latest')
        end

        it { is_expected.to contain_file("#{@configdir}/#{@configfile}").with_content(/Include=#{@includesdir}\/userparams.conf/) }

        it 'should set LogFileSize=0' do
          is_expected.to contain_file("#{@configdir}/#{@configfile}").with_content(/LogFileSize=0/)
        end

        it 'should set Server and ServerActive to zabbix.example.com,offsite.example.com' do
          is_expected.to contain_file("#{@configdir}/#{@configfile}").with_content(/Server=zabbix.example.com,offsite.example.com/)
          is_expected.to contain_file("#{@configdir}/#{@configfile}").with_content(/ServerActive=zabbix.example.com,offiste.example.com/)
        end
      end # ends describe 'with exmaple settings from README.md'

      describe 'post v2.1.0' do
        context 'with include_dir set' do
          let :pre_condition do
            "class {'zabbixagent':
              include_dir => 'zabbix_agent.d',
            }"
          end

          it 'should raise error' do
            expect {
              is_expected.to compile
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
              is_expected.to compile
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
              is_expected.to compile
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
              is_expected.to compile
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
              is_expected.to compile
            }.to raise_error(/servers_active was removed in v2.1. Please update/)
          end
        end
      end # ends describe 'post v2.1.0'

      describe 'with version set' do
        context 'to 2.4 with log_type' do
          let :pre_condition do
            "class {'zabbixagent':
              log_type => 'system',
              version  => '2.4'
            }"
          end

          it 'should raise error' do
            expect {
              is_expected.to compile
            }.to raise_error(/The parameter log_type is only supported since Zabbix 3.0./)
          end
        end

        context 'to 2.4 with tls_connect' do
          let :pre_condition do
            "class {'zabbixagent':
              tls_connect => 'cert',
              version  => '2.4'
            }"
          end

          it 'should raise error' do
            expect {
              is_expected.to compile
            }.to raise_error(/The parameter tls_connect is only supported since Zabbix 3.0./)
          end
        end
      end # ends describe 'with version set'
    end
  end
end

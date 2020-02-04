require 'spec_helper'

describe 'zabbixagent' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:node) { 'SOMEHOST.example.com' }
      let(:facts) { os_facts }

      context 'with repo management enabled' do
        let(:params) do
          {
            manage_repo_epel: true,
            manage_repo_zabbix: true,
          }
        end

        it { is_expected.to compile.with_all_deps }

        # Check that all classes are present
        it { is_expected.to contain_class('zabbixagent::preinstall') }
        it { is_expected.to contain_class('zabbixagent::install') }
        it { is_expected.to contain_class('zabbixagent::config') }
        it { is_expected.to contain_class('zabbixagent::service') }
      end # with repo management enabled

      context 'with exmaple settings from README.md' do
        it { is_expected.to contain_package('zabbix-agent').with_ensure('latest') }

        case os_facts[:kernel]
        when 'Linux'
          let(:params) do
            {
              ensure_setting: 'latest',
              include_files: ['/etc/zabbix_agentd.conf.d/userparams.conf'],
              log_file_size: 0,
              server: 'zabbix.example.com,offsite.example.com',
              server_active: ['zabbix.example.com', 'offiste.example.com'],
            }
          end

          it 'sets Include=/etc/zabbix_agentd.conf.d/userparams.conf' do
            is_expected.to contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(%r{Include=\/etc\/zabbix_agentd.conf.d\/userparams.conf})
          end

          it 'sets LogFileSize=0 when the kernel is "Linux"' do
            is_expected.to contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(%r{LogFileSize=0})
          end

          it 'sets Server and ServerActive to zabbix.example.com,offsite.example.com when the kernel is "Linux"' do
            is_expected.to contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(%r{Server=zabbix.example.com,offsite.example.com})
            is_expected.to contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(%r{ServerActive=zabbix.example.com,offiste.example.com})
          end
        when 'windows'
          let(:params) do
            {
              ensure_setting: 'latest',
              include_files: ['C:/ProgramData/zabbix_agentd.conf.d/userparams.conf'],
              log_file_size: 0,
              server: 'zabbix.example.com,offsite.example.com',
              server_active: ['zabbix.example.com', 'offiste.example.com'],
            }
          end

          it 'sets Include=C:/ProgramData/zabbix_agentd.conf.d/userparams.conf' do
            is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf').with_content(%r{Include=C:\/ProgramData\/zabbix_agentd.conf.d\/userparams.conf})
          end

          it 'sets LogFileSize=0 when the kernel is "windows"' do
            is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf').with_content(%r{LogFileSize=0})
          end

          it 'sets Server and ServerActive to zabbix.example.com,offsite.example.com when the kernel is "windows"' do
            is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf').with_content(%r{Server=zabbix.example.com,offsite.example.com})
            is_expected.to contain_file('C:/ProgramData/zabbix/zabbix_agentd.conf').with_content(%r{ServerActive=zabbix.example.com,offiste.example.com})
          end
        end # case
      end # 'with exmaple settings from README.md'

      context 'with custom require settings' do
        let(:pre_condition) do
          "class profile::foo {}
          class profile::bar {}"
        end

        let(:params) do
          {
            custom_require_linux: 'profile::foo',
            custom_require_windows: 'profile::bar',
          }
        end

        case os_facts[:kernel]
        when 'Linux'
          it { is_expected.to contain_class('profile::foo').with_before('["Package[zabbix-agent]"]') }
        when 'windows'
          it { is_expected.to contain_class('profile::bar').with_before('["Package[zabbix-agent]"]') }
        end # case
      end # 'with custom require settings'
    end # on #{os}
  end # on_supported_os
end # zabbixagent

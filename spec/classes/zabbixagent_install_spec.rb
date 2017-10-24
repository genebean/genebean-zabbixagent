require 'spec_helper'

describe 'zabbixagent::install' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      case facts[:os]['family']
      when 'Suse'
        context 'with repo management enabled' do
          let :pre_condition do
            "class {'zabbixagent':
              manage_repo_zabbix => true,
              version            => '3.2',
            }"
          end

          it { is_expected.to raise_error(/Repository managment for the SUSE family is disabled/) }
        end
        context 'with repo management disabled' do
          let :pre_condition do
            "class {'zabbixagent':
              manage_repo_zabbix => false,
              version            => '3.2',
            }"
          end

          # Make sure package will be installed.
          it { is_expected.to contain_package('zabbix-agent').with_ensure('present') }
          it { is_expected.to contain_package('zabbix-agent').with_name('zabbix-agent') }
        end
      when 'windows'
        context 'with defaults' do
          let :pre_condition do
            'include ::zabbixagent'
          end

          # Make sure package will be installed.
          it { is_expected.to contain_package('zabbix-agent').with_ensure('present') }
          it { is_expected.to contain_package('zabbix-agent').with_name('zabbix-agent') }
          it { is_expected.to contain_package('zabbix-agent').with_provider('chocolatey') }
        end
      else
        context 'with repo management enabled' do
          let :pre_condition do
            "class {'zabbixagent':
              manage_repo_epel   => true,
              manage_repo_zabbix => true,
            }"
          end

          # Make sure package will be installed.
          it { is_expected.to contain_package('zabbix-agent').with_ensure('present') }
          it { is_expected.to contain_package('zabbix-agent').with_name('zabbix-agent') }
        end # ends context 'with repo management enabled'
      end # ends case facts[:osfamily]
    end
  end
end

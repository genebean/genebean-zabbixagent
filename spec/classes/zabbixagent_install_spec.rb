require 'spec_helper'

describe 'zabbixagent::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:node) { 'SOMEHOST.example.com' }
      let(:facts) { os_facts }

      context 'with repo management enabled' do
        let :pre_condition do
          "class {'zabbixagent':
            manage_repo_epel   => true,
            manage_repo_zabbix => true,
          }"
        end

        it { is_expected.to contain_package('zabbix-agent').with_ensure('present') }
        it { is_expected.to contain_package('zabbix-agent').with_name('zabbix-agent') }

        case os_facts[:os]['family']
        when 'windows'
          it { is_expected.to contain_package('zabbix-agent').with_provider('chocolatey') }
        end
      end # 'with repo management enabled
    end # on #{os}
  end # on_supported_os
end # zabbixagent::install

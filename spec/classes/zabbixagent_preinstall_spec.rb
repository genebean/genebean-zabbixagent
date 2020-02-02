require 'spec_helper'

describe 'zabbixagent::preinstall' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:node) { 'SOMEHOST.example.com' }
      let(:facts) { os_facts }

      let :pre_condition do
        "class {'zabbixagent':
          manage_repo_zabbix => true,
          manage_repo_epel   => true,
          version            => '3.2',
        }"
      end

      case os_facts[:os]['family']
      when 'RedHat'
        it { is_expected.to contain_file('/etc/yum.repos.d/zabbix.repo') }
        it { is_expected.to contain_file('/etc/yum.repos.d/epel.repo') }
      when 'Debian'
        it { is_expected.to contain_file('/etc/apt/sources.list.d/zabbix.list') }
      end
    end # on #{os}
  end # on_supported_os
end # zabbixagent::preinstall

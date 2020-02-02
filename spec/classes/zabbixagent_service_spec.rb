require 'spec_helper'

describe 'zabbixagent::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:node) { 'SOMEHOST.example.com' }
      let(:facts) { os_facts }

      let(:pre_condition) { 'include zabbixagent' }

      it { is_expected.to contain_service('zabbix-agent').with_ensure('running') }
      it { is_expected.to contain_service('zabbix-agent').with_enable('true') }

      case os_facts[:kernel]
      when 'Linux'
        it { is_expected.to contain_service('zabbix-agent').with_name('zabbix-agent') }
      when 'windows'
        it { is_expected.to contain_service('zabbix-agent').with_name('Zabbix Agent') }
      end
    end # on #{os}
  end # on_supported_os
end # zabbixagent::service

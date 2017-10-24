require 'spec_helper'

describe 'zabbixagent::service' do
  on_supported_os.each do |os, facts|
    context "on #{os} with defaults" do
      let(:facts) do
        facts
      end

      let :pre_condition do
        'include ::zabbixagent'
      end

      # Make sure service will be running and enabled.
      it { is_expected.to contain_service('zabbix-agent').with_ensure('running') }
      it { is_expected.to contain_service('zabbix-agent').with_enable('true') }

      case facts[:os]['family']
      when 'windows'
        it { is_expected.to contain_service('zabbix-agent').with_name('Zabbix Agent') }
      when 'Suse'
        it { is_expected.to contain_service('zabbix-agent').with_name('zabbix-agentd') }
      else
        it { is_expected.to contain_service('zabbix-agent').with_name('zabbix-agent') }
      end # ends case facts[:os]['family']
    end # ends context "on #{os} with defaults" do
  end # ends on_supported_os.each do |os, facts|

  ################################################
  #
  #    These are not yet supported by facterdb
  #    Once they are, migrate settings to above
  #
  ################################################

  # Running a OpenSuSE.
  context 'On OpenSuSE Leap 42.1 with defaults' do
    let :pre_condition do
      'include ::zabbixagent'
    end

    let(:facts) do
      {
        'kernel' => 'Linux',
        'os'     => {
          'family'  => 'Suse',
          'name'    => 'OpenSuSE',
          'release' => {
            'full' => '42.1',
          },
        },
      }
    end

    # Make sure service will be running and enabled.
    it { is_expected.to contain_service('zabbix-agent').with_ensure('running') }
    it { is_expected.to contain_service('zabbix-agent').with_name('zabbix-agentd') }
    it { is_expected.to contain_service('zabbix-agent').with_enable('true') }
  end
end

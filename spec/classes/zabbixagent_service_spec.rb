require 'spec_helper'

describe 'zabbixagent::service' do

  # Running a RedHat OS.
  context 'On a RedHat OS with repo management enabled' do
    let :pre_condition do
      "class {'zabbixagent':
        manage_repo_epel   => true,
        manage_repo_zabbix => true,
      }"
    end

    let :facts do
      {
          :kernel          => 'Linux',
          :osfamily        => 'RedHat',
          :operatingsystem => 'RedHat'
      }
    end

    # Make sure service will be running and enabled.
    it { should contain_service('zabbix-agent').with_ensure('running') }
    it { should contain_service('zabbix-agent').with_name('zabbix-agent') }
    it { should contain_service('zabbix-agent').with_enable('true') }
  end

  # Running a Windows OS.
  context 'On Windows' do
    let :pre_condition do
      "include zabbixagent"
    end

    let :facts do
      {
          :kernel          => 'windows',
          :osfamily        => 'windows',
          :operatingsystem => 'windows'
      }
    end

    # Make sure service will be running and enabled.
    it { should contain_service('zabbix-agent').with_ensure('running') }
    it { should contain_service('zabbix-agent').with_name('Zabbix Agent') }
    it { should contain_service('zabbix-agent').with_enable('true') }
  end

  # Running a OpenSuSE OS.
  context 'On OpenSuSE Leap 42.1 OS with repo management enabled' do
    let :pre_condition do
      "class {'zabbixagent':
        manage_repo_zabbix => true,
      }"
    end

    let :facts do
      {
          :kernel                 => 'Linux',
          :osfamily               => 'Suse',
          :operatingsystem        => 'OpenSuSE',
          :operatingsystemrelease => '42.1'
      }
    end

    # Make sure service will be running and enabled.
    it { should contain_service('zabbix-agent').with_ensure('running') }
    it { should contain_service('zabbix-agent').with_name('zabbix-agentd') }
    it { should contain_service('zabbix-agent').with_enable('true') }
  end

  # Running a SLES OS.
  context 'On SLES 12.1 OS with repo management enabled' do
    let :pre_condition do
      "class {'zabbixagent':
        manage_repo_zabbix => true,
      }"
    end

    let :facts do
      {
          :kernel                 => 'Linux',
          :osfamily               => 'Suse',
          :operatingsystem        => 'SLES',
          :operatingsystemrelease => '12.1'
      }
    end

    # Make sure service will be running and enabled.
    it { should contain_service('zabbix-agent').with_ensure('running') }
    it { should contain_service('zabbix-agent').with_name('zabbix-agentd') }
    it { should contain_service('zabbix-agent').with_enable('true') }
  end
end

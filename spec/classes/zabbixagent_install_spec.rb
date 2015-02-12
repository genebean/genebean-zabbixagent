require 'spec_helper'

describe 'zabbixagent::install' do

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

    # Make sure package will be installed.
    it { should contain_package('zabbix-agent').with_ensure('present') }
    it { should contain_package('zabbix-agent').with_name('zabbix-agent') }

  end

  # Running Windows.
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

    # Make sure package will be installed.
    it { should contain_package('zabbix-agent').with_ensure('present') }
    it { should contain_package('zabbix-agent').with_name('zabbix-agent') }
    it { should contain_package('zabbix-agent').with_provider('chocolatey') }

  end
end
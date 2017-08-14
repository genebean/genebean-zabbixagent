require 'spec_helper'

describe 'zabbixagent' do

  on_supported_os.each do |os, facts|
    context "on #{os} with defaults" do
      let(:facts) do
        facts
      end

      # Check that all classes are present
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('zabbixagent') }
      it { is_expected.to contain_class('zabbixagent::install') }
      it { is_expected.to contain_class('zabbixagent::install') }
      it { is_expected.to contain_class('zabbixagent::config') }
      it { is_expected.to contain_class('zabbixagent::service') }
    end
  end

  describe 'with server and server_active params set' do
    let :facts do
      {
        :kernel          => 'Linux',
        :osfamily        => 'RedHat',
        :operatingsystem => 'RedHat'
      }
    end

    context 'to a single server' do
      let :pre_condition do
        "class {'zabbixagent':
          server        => 'zabbix.example.com',
          server_active => 'zabbix.example.com',
        }"
      end

      it 'should pass parameters to zabbixagent' do
        should contain_class('zabbixagent').with(
          'server'        => 'zabbix.example.com',
          'server_active' => 'zabbix.example.com',
        )
      end
    end

    context 'to an array of servers' do
      let :pre_condition do
        "class {'zabbixagent':
          server        => ['zabbix.example.com', 'node.example.com'],
          server_active => ['zabbix.example.com', 'node.example.com'],
        }"
      end

      it 'should pass parameters to zabbixagent' do
        should contain_class('zabbixagent').with(
          'server'        => '["zabbix.example.com", "node.example.com"]',
          'server_active' => '["zabbix.example.com", "node.example.com"]',
        )
      end
    end

  end

  describe 'with exmaple settings from README.md' do
    let :pre_condition do
      "class { 'zabbixagent':
        ensure_setting => 'latest',
        include_files  => ['/etc/zabbix_agentd.conf.d/userparams.conf',],
        log_file_size  => 0,
        server         => 'zabbix.example.com,offsite.example.com',
        server_active  => ['zabbix.example.com', 'offiste.example.com',],
      }"
    end

    let :facts do
      {
        :kernel          => 'Linux',
        :osfamily        => 'RedHat',
        :operatingsystem => 'RedHat'
      }
    end

    it 'should ensure => latest' do
      should contain_package('zabbix-agent').with_ensure('latest')
    end

    it 'should set Include=/etc/zabbix_agentd.conf.d/userparams.conf' do
      should contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(/Include=\/etc\/zabbix_agentd.conf.d\/userparams.conf/)
    end

    it 'should set LogFileSize=0' do
      should contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(/LogFileSize=0/)
    end

    it 'should set Server and ServerActive to zabbix.example.com,offsite.example.com' do
      should contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(/Server=zabbix.example.com,offsite.example.com/)
      should contain_file('/etc/zabbix/zabbix_agentd.conf').with_content(/ServerActive=zabbix.example.com,offiste.example.com/)
    end
  end

  describe 'with custom require settings' do
    let :pre_condition do
      "include ::stdlib
      
      class { 'zabbixagent':
        custom_require_linux   => Class['stdlib'],
        custom_require_windows => Class['stdlib'],
      }"
    end

    context 'on Linux' do
      let :facts do
        {
            :kernel          => 'Linux',
            :osfamily        => 'RedHat',
            :operatingsystem => 'RedHat'
        }
      end

      it "should require => Class[Stdlib]" do
        should contain_package('zabbix-agent').that_requires("Class[Stdlib]")
      end
    end

    context 'on Windows' do
      let :facts do
        {
            :kernel          => 'windows',
            :osfamily        => 'windows',
            :operatingsystem => 'windows'
        }
      end

      it "should require => Class[Stdlib]" do
        should contain_package('zabbix-agent').that_requires("Class[Stdlib]")
      end
    end
  end

  describe 'post v2.1.0' do
    let :facts do
      {
        :kernel          => 'Linux',
        :osfamily        => 'RedHat',
        :operatingsystem => 'RedHat'
      }
    end

    context 'with include_dir set' do
      let :pre_condition do
        "class {'zabbixagent':
          include_dir => 'zabbix_agent.d',
        }"
      end

      it 'should raise error' do
        expect {
          should compile
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
          should compile
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
          should compile
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
          should compile
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
          should compile
        }.to raise_error(/servers_active was removed in v2.1. Please update/)
      end
    end

  end

  describe 'with version set' do
    let :facts do
      {
        :kernel          => 'Linux',
        :osfamily        => 'RedHat',
        :operatingsystem => 'RedHat'
      }
    end

    context 'to 2.4 with log_type' do
      let :pre_condition do
        "class {'zabbixagent':
          log_type => 'system',
          version  => '2.4'
        }"
      end

      it 'should raise error' do
        expect {
          should compile
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
          should compile
        }.to raise_error(/The parameter tls_connect is only supported since Zabbix 3.0./)
      end
    end

  end

  context 'on Ubuntu 14.04 LTS (Trusty)' do
    let :facts do
      {
          :kernel          => 'Linux',
          :osfamily        => 'Debian',
          :operatingsystem => 'Ubuntu',
          :lsbdistcodename => 'trusty'
      }
    end

    let(:params) {
      {
          :manage_repo_zabbix => true
      }
    }

    it { is_expected.to compile.with_all_deps }
  end

  context 'on Ubuntu 16.04 (Xenial Xerus)' do
    let :facts do
      {
          :kernel          => 'Linux',
          :osfamily        => 'Debian',
          :operatingsystem => 'Ubuntu',
          :lsbdistcodename => 'xenial'
      }
    end

    let(:params) {
      {
          :manage_repo_zabbix => true
      }
    }

    it { is_expected.to compile.with_all_deps }
  end

  context 'on Debian 7 (Wheezy)' do
    let :facts do
      {
          :kernel          => 'Linux',
          :osfamily        => 'Debian',
          :operatingsystem => 'Debian',
          :lsbdistcodename => 'wheezy'
      }
    end

    let(:params) {
      {
          :manage_repo_zabbix => true
      }
    }

    it { is_expected.to compile.with_all_deps }
  end

  context 'on Debian 8 (Jessie)' do
    let :facts do
      {
          :kernel          => 'Linux',
          :osfamily        => 'Debian',
          :operatingsystem => 'Ubuntu',
          :lsbdistcodename => 'jessie'
      }
    end

    let(:params) {
      {
          :manage_repo_zabbix => true
      }
    }

    it { is_expected.to compile.with_all_deps }
  end
end

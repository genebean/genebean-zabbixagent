require 'spec_helper'

describe 'zabbixagent::preinstall' do
  on_supported_os.each do |os, facts|
    context "on #{os} with repo management enabled" do
      let(:facts) do
        facts
      end

      let :pre_condition do
        "class {'zabbixagent':
          manage_repo_zabbix => true,
          manage_repo_epel   => true,
          version            => '3.2',
        }"
      end
      case facts[:os]['family']
      when 'RedHat'
        it 'should create epel.repo' do
          should contain_file('/etc/yum.repos.d/epel.repo').with_content(/mirrorlist=https:\/\/mirrors.fedoraproject.org\/.*epel-#{facts[:os]['release']['major']}/)
        end

        case facts[:os]['release']['major']
        when '5'
          it 'should create zabbix.repo' do
            should contain_file('/etc/yum.repos.d/zabbix.repo').with_content(/baseurl=http:\/\/repo.zabbix.com\/zabbix\/3.2\/rhel\/#{facts[:os]['release']['major']}\/\$basearch\//)
            should contain_file('/etc/yum.repos.d/zabbix.repo').with_content(/gpgkey=http:\/\/repo.zabbix.com\/RPM-GPG-KEY-ZABBIX-A14FE591-EL5/)
          end
        else
          it 'should create zabbix.repo' do
            should contain_file('/etc/yum.repos.d/zabbix.repo').with_content(/baseurl=http:\/\/repo.zabbix.com\/zabbix\/3.2\/rhel\/#{facts[:os]['release']['major']}\/\$basearch\//)
            should contain_file('/etc/yum.repos.d/zabbix.repo').with_content(/gpgkey=http:\/\/repo.zabbix.com\/RPM-GPG-KEY-ZABBIX-A14FE591/)
          end
        end # ends case facts[:operatingsystemmajrelease]
      when 'Debian'
        it 'should create zabbix.list' do
          should contain_file('/etc/apt/sources.list.d/zabbix.list').with_content(/deb http:\/\/repo.zabbix.com\/zabbix\/3.2\/#{facts[:os]['name'].downcase} #{facts[:os]['lsb']['distcodename']} main/)
        end
      when 'Suse'
        it {should raise_error(/Repository managment for the SUSE family is disabled/)}
      end # ends case facts[:osfamily]
    end # ends context "on #{os} with repo management enabled"
  end # ends on_supported_os.each do |os, facts|

  ################################################
  #
  #    These are not yet supported by facterdb
  #    Once they are, migrate settings to above
  #
  ################################################

  # Running an OpenSuSE OS.
  context 'On a OpenSuSE Leap 42.1 with repo management enabled' do
    let(:facts) do
      {
          'kernel' => 'Linux',
          'os'     => {
            'family'  => 'Suse',
            'name'    => 'OpenSuSE',
            'release' => {
              'full' => '42.1'
            },
          },
      }
    end

    let :pre_condition do
      "class {'zabbixagent':
        manage_repo_zabbix => true,
      }"
    end

    it {should raise_error(/Repository managment for the SUSE family is disabled/)}
  end # ens context 'On a OpenSuSE Leap 42.1 with repo management enabled'
end

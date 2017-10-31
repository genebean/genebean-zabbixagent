# Repositories used by Zabbix
class zabbixagent::preinstall inherits zabbixagent {
  case $facts['os']['family'] {
    'RedHat'  : {
      # EPEL
      if ($zabbixagent::manage_repo_epel) {
        file { '/etc/yum.repos.d/epel.repo':
          ensure  => file,
          content => epp('zabbixagent/epel.repo.epp'),
          notify  => Exec['yum clean all'],
        }

        file { '/etc/yum.repos.d/epel-testing.repo':
          ensure  => file,
          content => epp('zabbixagent/epel-testing.repo.epp'),
          notify  => Exec['yum clean all'],
        }
      }

      # Zabbix
      if ($zabbixagent::manage_repo_zabbix) {
        file { '/etc/yum.repos.d/zabbix.repo':
          ensure  => file,
          content => epp('zabbixagent/zabbix.repo.epp'),
          notify  => Exec['yum clean all'],
        }
      }

      exec { 'yum clean all':
        path        => '/usr/bin',
        user        => 'root',
        logoutput   => true,
        refreshonly => true,
        command     => 'yum clean all',
      }

    } # end RedHat

    'Debian'  : {
      if ($zabbixagent::manage_repo_zabbix) {
        file { '/etc/apt/sources.list.d/zabbix.list':
          ensure  => file,
          content => epp('zabbixagent/zabbix.list.epp'),
          notify  => Exec['apt-get update'],
        }

        exec { 'apt-get update':
          path        => '/usr/bin',
          user        => 'root',
          logoutput   => true,
          refreshonly => true,
          command     => 'apt-get update',
        }
      }

    } # end Debian

    'Suse' : {
      if ($zabbixagent::manage_repo_zabbix) {
        file { '/etc/zypp/repos.d/home_pclo_monitoring.repo':
          ensure  => file,
          content => epp('zabbixagent/home_pclo_monitoring.repo.epp'),
          notify  => Exec['zypper refresh'],
        }
      }

      exec { 'zypper refresh':
        path        => '/usr/bin',
        user        => 'root',
        logoutput   => true,
        refreshonly => true,
        command     => 'zypper --gpg-auto-import-keys refresh',
      }
    } # end Suse

    default : {
    }
  } # end case $::osfamily
} # end class

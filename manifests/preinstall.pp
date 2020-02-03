# Repositories used by Zabbix
class zabbixagent::preinstall (
  $manage_repo_epel   = $zabbixagent::manage_repo_epel,
  $manage_repo_zabbix = $zabbixagent::manage_repo_zabbix,
  $version            = $zabbixagent::version,) {
  case $facts['os']['family'] {
    'RedHat'  : {
      # EPEL
      if ($manage_repo_epel) {
        file { '/etc/yum.repos.d/epel.repo':
          ensure  => file,
          content => template('zabbixagent/epel.repo.erb'),
          notify  => Exec['yum clean all'],
        }

        file { '/etc/yum.repos.d/epel-testing.repo':
          ensure  => file,
          content => template('zabbixagent/epel-testing.repo.erb'),
          notify  => Exec['yum clean all'],
        }
      }

      # Zabbix
      if ($manage_repo_zabbix) {
        file { '/etc/yum.repos.d/zabbix.repo':
          ensure  => file,
          content => template('zabbixagent/zabbix.repo.erb'),
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
      if ($manage_repo_zabbix) {
        file { '/etc/apt/sources.list.d/zabbix.list':
          ensure  => file,
          content => template('zabbixagent/zabbix.list.erb'),
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
      case $facts['os']['name'] {

        'SLES' : {
          case $facts['os']['release']['full'] {

            '11.3', '11.4', '12.0', '12.1' : {
              # Zabbix
              if ($manage_repo_zabbix) {
                file { '/etc/zypp/repos.d/server_monitoring.repo':
                  ensure  => file,
                  content => template('zabbixagent/server_monitoring.repo.erb'),
                  notify  => Exec['zypper refresh'],
                }
              }
            }

            default : {
              # lint:ignore:80chars
              fail("${facts['os']['name']} ${facts['os']['release']['full']} is not supported")
              # lint:endignore
            }

          } # end case $facts['os']['release']['full']

        } # end SLES

        'OpenSuSE' : {
          if ($manage_repo_zabbix) {
            file { '/etc/zypp/repos.d/server_monitoring.repo':
              ensure  => file,
              content => template('zabbixagent/server_monitoring.repo.erb'),
              notify  => Exec['zypper refresh'],
            }
          }
        } # end OpenSuSE

        default : {
        }

      } # end case $facts['os']['name']



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

  } # end case $facts['os']['family']
} # end class

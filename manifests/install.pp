# Installs the zabbix agent
class zabbixagent::install inherits zabbixagent {

  $_package_name = $::osfamily ? {
    'Suse' => $zabbixagent::version ? {
      '2.4'   => 'zabbix24-agent',
      '3.0'   => 'zabbix30-agent',
      '3.2'   => 'zabbix32-agent',
      default => 'zabbix32-agent',
    },

    default => $zabbixagent::package_name,
  }

  case $facts['kernel'] {
    'Linux'   : {

      if ($_package_name != 'zabbix-agent') {
        package { 'zabbix-agent':
          ensure => absent,
          before => Package[$_package_name],
        }
      }

      package { $_package_name:
        ensure  => $zabbixagent::ensure_setting,
        notify  => Class['::zabbixagent::service'],
        require => $zabbixagent::custom_require_linux,
      }

    } # end Linux

    'Windows' : {
      package { $_package_name:
        ensure   => $zabbixagent::ensure_setting,
        provider => 'chocolatey',
        notify   => Class['::zabbixagent::service'],
        require  => $zabbixagent::custom_require_windows,
      }
    } # end Windows

    default : {
      fail($zabbixagent::fail_message)
    }
  }
}

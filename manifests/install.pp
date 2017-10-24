# Installs the zabbix agent
class zabbixagent::install inherits zabbixagent {

  $_package_name = $zabbixagent::package_name

  case $facts['kernel'] {
    'Linux'   : {

      if ($_package_name != 'zabbix-agent') {
        package { 'standard zabbix-agent':
          ensure => absent,
          name   => 'zabbix-agent',
          before => Package['zabbix-agent'],
        }
      }

      package { 'zabbix-agent':
        ensure  => $zabbixagent::ensure_setting,
        name    => $_package_name,
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

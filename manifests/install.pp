# Installs the zabbix agent
class zabbixagent::install {
  case $facts['kernel'] {
    'Linux'   : {

      if ($zabbixagent::package_name != 'zabbix-agent') {
        package { 'zabbix-agent':
          ensure => absent,
          before => Package[$zabbixagent::package_name],
        }
      }

      if ($zabbixagent::custom_require_linux) {
        include $zabbixagent::custom_require_linux
        Class[$zabbixagent::custom_require_linux] -> Package[$zabbixagent::package_name]
      }

      package { $zabbixagent::package_name:
        ensure => $zabbixagent::ensure_setting,
        notify => Service[$zabbixagent::service_name],
      }

    } # end Linux

    'windows' : {
      if ($zabbixagent::custom_require_windows) {
        include $zabbixagent::custom_require_windows
        Class[$zabbixagent::custom_require_windows] -> Package[$zabbixagent::package_name]
      }

      package { $zabbixagent::package_name:
        ensure   => $zabbixagent::ensure_setting,
        provider => 'chocolatey',
        notify   => Service['zabbix-agent'],
      }
    } # end windows

    default : {
      fail("${facts['kernel']} is not yet supported by this module.")
    }
  }
}

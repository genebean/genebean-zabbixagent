# Installs the zabbix agent
class zabbixagent::install (
  $ensure_setting         = $zabbixagent::ensure_setting,
  $custom_require_linux   = $zabbixagent::custom_require_linux,
  $custom_require_windows = $zabbixagent::custom_require_windows,
  $package_name           = $zabbixagent::package_name,
  $version                = $zabbixagent::version) {
  case $facts['kernel'] {
    'Linux'   : {

      if ($package_name != 'zabbix-agent') {
        package { 'zabbix-agent':
          ensure => absent,
          before => Package[$package_name],
        }
      }

      if ($custom_require_linux) {
        include $custom_require_linux
        Class[$custom_require_linux] -> Package[$package_name]
      }

      package { $package_name:
        ensure => $ensure_setting,
        notify => Service[$zabbixagent::params::service_name],
      }

    } # end Linux

    'Windows' : {
      if ($custom_require_windows) {
        include $custom_require_windows
        Class[$custom_require_windows] -> Package[$package_name]
      }

      package { $package_name:
        ensure   => $ensure_setting,
        provider => 'chocolatey',
        notify   => Service['zabbix-agent'],
      }
    } # end Windows

    default : {
      fail($zabbixagent::params::fail_message)
    }
  }
}

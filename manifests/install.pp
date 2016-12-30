# Installs the zabbix agent
class zabbixagent::install (
  $ensure_setting         = $::zabbixagent::ensure_setting,
  $custom_require_linux   = $::zabbixagent::custom_require_linux,
  $custom_require_windows = $::zabbixagent::custom_require_windows,
  $windows_package_name   = $::zabbixagent::windows_package_name,
  $windows_package_source = $::zabbixagent::windows_package_source ) {
  case $::kernel {
    'Linux'   : {

      package { 'zabbix-agent':
        ensure  => $ensure_setting,
        notify  => Service[$::zabbixagent::params::service_name],
        require => $custom_require_linux,
      }

    } # end Linux

    'Windows' : {
      package { $windows_package_name:
        ensure   => $ensure_setting,
        provider => 'chocolatey',
        source   => $windows_package_source,
        notify   => Service['zabbix-agent'],
        require  => $custom_require_windows,
      }
    } # end Windows

    default : {
      fail($::zabbixagent::params::fail_message)
    }
  }
}

# Installs the zabbix agent
class zabbixagent::install (
  $ensure_setting         = $::zabbixagent::ensure_setting,
  $custom_require_linux   = $::zabbixagent::custom_require_linux,
  $custom_require_windows = $::zabbixagent::custom_require_windows,
  $package_name           = $::zabbixagent::package_name,
  $version                = $::zabbixagent::version) {
  case $::kernel {
    'Linux'   : {

      if ($package_name != 'zabbix-agent') {
        package { 'zabbix-agent':
          ensure => absent,
          before => Package[$package_name],
        }
      }

      package { $package_name:
        ensure  => $ensure_setting,
        notify  => Service[$::zabbixagent::params::service_name],
        require => $custom_require_linux,
      }

    } # end Linux

    'Windows' : {
      package { $package_name:
        ensure   => $ensure_setting,
        provider => 'chocolatey',
        notify   => Service['zabbix-agent'],
        require  => $custom_require_windows,
      }
    } # end Windows

    default : {
      fail($::zabbixagent::params::fail_message)
    }
  }
}

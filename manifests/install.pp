# Installs the zabbix agent
class zabbixagent::install (
  $ensure_setting         = $::zabbixagent::ensure_setting,
  $custom_require_linux   = $::zabbixagent::custom_require_linux,
  $custom_require_windows = $::zabbixagent::custom_require_windows) {
  case $::kernel {
    Linux   : {
      package { 'zabbix-agent':
        ensure  => $ensure_setting,
        notify  => Service['zabbix-agent'],
        require => $custom_require_linux,
      }
    } # end Linux

    Windows : {
      package { 'zabbix-agent':
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

# Class: zabbixagent
#
# This module manages the zabbix agent on a monitored machine.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class zabbixagent(
  $servers = '',
  $hostname = '',
) {
  if ($servers = '') {
    $servers_real = 'localhost'
  }
  else {
    $servers_real = $servers
  }

  if ($hostname = '') {
    $hostname_real = $::hostname
  }
  else {
    $hostname_real = $hostname
  }

  package {'zabbix-agent' :
    ensure  => installed,
  }

  service {'zabbix-agent' :
    ensure  => running,
    enable  => true,
    require => Package['zabbix-agent'],
  }

  file {'/etc/zabbix/zabbix_agentd.conf' :
    content => template('zabbixagent/zabbix_agentd.conf.unix.erb'),
    require => Package['zabbix-agent'],
    notify  => Service['zabbix-agent'],
  }
}
# Manages configuration of the Zabbix agent and associated repos (if enabled)
class zabbixagent::config {
  file { $zabbixagent::config_dir:
    ensure => directory,
  }

  file { "${zabbixagent::config_dir}/zabbix_agentd.conf":
    ensure  => file,
    content => template('zabbixagent/zabbix_agentd.conf.erb'),
    require => File[$zabbixagent::config_dir],
    notify  => Service['zabbix-agent'],
  }

}

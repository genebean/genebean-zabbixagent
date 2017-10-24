# Manages configuration of the Zabbix agent and associated repos (if enabled)
class zabbixagent::config inherits zabbixagent {
  file { $zabbixagent::config_dir:
    ensure => directory,
  }

  file { "${zabbixagent::config_dir}/${zabbixagent::config_name}":
    ensure  => file,
    content => epp('zabbixagent/zabbix_agentd.conf.epp'),
    require => File[$zabbixagent::config_dir],
    notify  => Class['::zabbixagent::service'],
  }

}

# Makes sure the service is running
class zabbixagent::service inherits zabbixagent {

  service { 'zabbix-agent':
    ensure  => running,
    name    => $zabbixagent::service_name,
    enable  => true,
    require => Class['::zabbixagent::install'],
  }
}

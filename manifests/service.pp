# Makes sure the service is running
class zabbixagent::service {
  service { 'zabbix-agent':
    ensure  => running,
    name    => $zabbixagent::service_name,
    enable  => true,
    require => Package[$zabbixagent::package_name],
  }
}

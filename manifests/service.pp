# Makes sure the service is running
class zabbixagent::service {

  service { 'zabbix-agent':
    ensure  => running,
    name    => $::zabbixagent::params::service_name,
    enable  => true,
    require => Package[$windows_package_name],
  }
}

# Makes sure the service is running
class zabbixagent::service(
  $package_name = $::zabbixagent::package_name,
  ) {

  service { 'zabbix-agent':
    ensure  => running,
    name    => $::zabbixagent::params::service_name,
    enable  => true,
    require => Package[$package_name],
  }
}

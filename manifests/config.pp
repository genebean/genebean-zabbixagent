# Manages configuration of the Zabbix agent and associated repos (if enabled)
class zabbixagent::config (
  $allow_root             = $::zabbixagent::allow_root,
  $buffer_send            = $::zabbixagent::buffer_send,
  $buffer_size            = $::zabbixagent::buffer_size,
  $config_dir             = $::zabbixagent::config_dir,
  $debug_level            = $::zabbixagent::debug_level,
  $enable_remote_commands = $::zabbixagent::enable_remote_commands,
  $host_metadata_item     = $::zabbixagent::host_metadata_item,
  $host_metadata          = $::zabbixagent::host_metadata,
  $hostname_item          = $::zabbixagent::hostname_item,
  $hostname               = $::zabbixagent::hostname,
  $include_files          = $::zabbixagent::include_files,
  $item_alias             = $::zabbixagent::item_alias,
  $listen_ip              = $::zabbixagent::listen_ip,
  $listen_port            = $::zabbixagent::listen_port,
  $load_module_path       = $::zabbixagent::load_module_path,
  $load_module            = $::zabbixagent::load_module,
  $log_file_size          = $::zabbixagent::log_file_size,
  $log_file               = $::zabbixagent::log_file,
  $log_remote_commands    = $::zabbixagent::log_remote_commands,
  $max_lines_per_second   = $::zabbixagent::max_lines_per_second,
  $perf_counter           = $::zabbixagent::perf_counter,
  $pid_file               = $::zabbixagent::pid_file,
  $refresh_active_checks  = $::zabbixagent::refresh_active_checks,
  $server_active          = $::zabbixagent::server_active,
  $server                 = $::zabbixagent::server,
  $source_ip              = $::zabbixagent::source_ip,
  $start_agents           = $::zabbixagent::start_agents,
  $timeout                = $::zabbixagent::timeout,
  $unsafe_user_parameters = $::zabbixagent::unsafe_user_parameters,
  $user_parameter         = $::zabbixagent::user_parameter,
  $user                   = $::zabbixagent::user,) {
  file { $::zabbixagent::params::config_dir:
    ensure => directory,
  }

  file { "${config_dir}/zabbix_agentd.conf":
    ensure  => file,
    content => template('zabbixagent/zabbix_agentd.conf.erb'),
    require => File[$::zabbixagent::params::config_dir],
    notify  => Service['zabbix-agent'],
  }

}

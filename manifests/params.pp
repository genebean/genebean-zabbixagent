# Parameters used by this module
class zabbixagent::params {
  # perinstall settings
  $manage_repo_epel       = false
  $manage_repo_zabbix     = false

  # install settings
  $ensure_setting         = 'present'

  # config settings
  $item_alias             = undef
  $allow_root             = undef
  $buffer_send            = undef
  $buffer_size            = undef
  $debug_level            = undef
  $enable_remote_commands = undef
  $host_metadata_item     = undef
  $host_metadata          = undef
  $hostname_item          = undef
  $hostname               = downcase($::fqdn)
  $include                = undef
  $listen_ip              = undef
  $listen_port            = undef
  $load_module_path       = undef
  $load_module            = undef
  $log_file_size          = undef
  $log_remote_commands    = undef
  $max_lines_per_second   = undef
  $perf_counter           = undef
  $pid_file               = undef
  $refresh_active_checks  = undef
  $server_active          = '127.0.0.1'
  $server                 = '127.0.0.1'
  $source_ip              = undef
  $start_agents           = undef
  $timeout                = undef
  $unsafe_user_parameters = undef
  $user_parameter         = undef
  $user                   = undef

  # this isn't a parameter but, since this class is inherited by all classes
  # it is a good place to put this message so that it's the same everywhere
  $fail_message           = "${::kernel} is not yet supported by this module."

  case $::kernel {
    'Linux'   : {
      $config_dir = '/etc/zabbix'
      $log_file   = '/var/log/zabbix/zabbix_agentd.log'
    }

    'Windows' : {
      $config_dir = 'C:/Program Files/Zabbix Agent'
      $log_file   = 'C:/zabbix_agentd.log'
    }

    default   : {
      fail($fail_message)
    }

  } # end case
}

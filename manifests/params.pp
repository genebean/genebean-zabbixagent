# Parameters used by this module
class zabbixagent::params {
  # perinstall settings
  $manage_repo_epel        = false
  $manage_repo_zabbix      = false

  # install settings
  $custom_require_linux    = undef
  $custom_require_windows  = undef
  $ensure_setting          = 'present'

  # config settings
  $allow_root              = undef
  $buffer_send             = undef
  $buffer_size             = undef
  $debug_level             = undef
  $enable_remote_commands  = undef
  $host_metadata           = undef
  $host_metadata_item      = 'system.uname'
  $hostname                = downcase($facts['networking']['fqdn'])
  $hostname_item           = undef
  $include_files           = undef
  $item_alias              = undef
  $listen_ip               = undef
  $listen_port             = undef
  $load_module             = undef
  $load_module_path        = undef
  $log_file_size           = undef
  $log_remote_commands     = undef
  $log_type                = undef
  $max_lines_per_second    = undef
  $perf_counter            = undef
  $pid_file                = '/var/run/zabbix/zabbix_agentd.pid'
  $refresh_active_checks   = undef
  $server                  = '127.0.0.1'
  $server_active           = '127.0.0.1'
  $source_ip               = undef
  $start_agents            = undef
  $timeout                 = undef
  $tls_accept              = undef
  $tls_ca_file             = undef
  $tls_cert_file           = undef
  $tls_connect             = undef
  $tls_crl_file            = undef
  $tls_key_file            = undef
  $tls_psk_file            = undef
  $tls_psk_identity        = undef
  $tls_server_cert_issuer  = undef
  $tls_server_cert_subject = undef
  $unsafe_user_parameters  = undef
  $user_parameter          = undef
  $user                    = undef
  $version                 = '3.2'

  # this isn't a parameter but, since this class is inherited by all classes
  # it is a good place to put this message so that it's the same everywhere
  $fail_message            = "${facts['kernel']} is not yet supported by this module."

  case $facts['kernel'] {
    'Linux'   : {
      $config_dir = '/etc/zabbix'
      $log_file   = '/var/log/zabbix/zabbix_agentd.log'
    }

    'windows' : {
      $config_dir = 'C:/ProgramData/zabbix'
      $log_file   = 'C:/zabbix_agentd.log'
    }

    default   : {
      fail($fail_message)
    }

  } # end case

  case $facts['os']['family'] {
    'Debian': {
      $package_name = 'zabbix-agent'
    }

    'Redhat': {
      $package_name = 'zabbix-agent'
    }

    'Suse': {
      $package_name = $version ? {
        '2.4'   => 'zabbix24-agent',
        '3.0'   => 'zabbix30-agent',
        '3.2'   => 'zabbix32-agent',
        default => 'zabbix32-agent',
      }
    }

    'Windows': {
      $package_name = 'zabbix-agent'
    }

    default: {
      $package_name = undef
    }
  }

  $service_name = $facts['os']['name'] ? {
    'Windows'            => 'Zabbix Agent',
    /(OpenSuSE|SLES)/    => 'zabbix-agentd',
    default              => 'zabbix-agent',
  }

  $config_name = $facts['os']['name'] ? {
    'Windows'            => 'zabbix_agentd.conf',
    /(OpenSuSE|SLES)/    => 'zabbix-agentd.conf',
    default              => 'zabbix_agentd.conf',
  }
}

# Class: zabbixagent
#
# This module manages the zabbix agent on a monitored machine.
#
# Unless listed otherwise below, all settings in zabbix_agentd.conf are
# ommitted unless a value is passed in. In the config file, setting names are
# capitalized and run together. Here, they share the same name but are lower
# case and have an underscore separating words. Ex: PidFile becomes pid_file.
#
# Parameters:
#   $manage_repo_epel          Determines if the EPEL repo is managed on the
#                              RedHat family of OS's.
#                              Default: false
#                              Type: boolean
#
#   $manage_repo_zabbix        Determines if the Zabbix repo is managed on the
#                              RedHat family of OS's.
#                              Default: false
#                              Type: boolean
#
#   $ensure_setting            Passed directly to ensure of package resource
#                              Default: 'present'
#
#   $config_dir                Defines the directory in which config files live
#                              Default on Linux:   '/etc/zabbix'
#                              Default on Windows: 'C:/ProgramData/zabbix'
#
#   $custom_require_linux      Passed directly to require of package resource
#                              when on Linux
#                              Default: undef
#
#   $custom_require_windows    Passed directly to require of package resource
#                              when on Windows
#                              Default: undef
#
#   $allow_root                0 - do not allow, 1 - allow
#                              Type: integer
#
#   $buffer_send               Range: 1-3600
#                              Type: integer
#
#   $buffer_size               Range: 2-65535
#                              Type: integer
#
#   $debug_level               Range: 0-4
#                              Type: integer
#
#   $enable_remote_commands    0 - not allowed, 1 - allowed
#                              Type: integer
#
#   $host_metadata             Range: 0-255 characters
#                              Type: string
#
#   $host_metadata_item        Parameter that defines an item used for getting
#                              host metadata used during host auto-registration
#                              process. To disable, set to ''.
#                              Default: 'system.uname'
#
#   $hostname                  The hostname used in the config file.
#                              Default: downcase($::fqdn)
#
#   $hostname_item             An item to be used for determining a host's name
#
#   $include_files             Equates to include in zabbix_agentd.conf.
#                              Renamed due to include being special in Puppet.
#                              An array with one or more files to be included
#                              in the config. On non-Windows systems, this can
#                              be a folder or a path with a wildcard. See
#                              zabbix_agentd.conf for details.
#                              Type: array
#
#   $item_alias                Equates to alias in zabbix_agentd.conf. Renamed
#                              due to alias being the name of a Puppet
#                              metaparameter. Sets an alias for an item key.
#                              Type: array
#
#   $listen_ip                 List of comma delimited IP addresses that the
#                              agent should listen on.
#                              Type: string
#
#   $listen_port               Range: 1024-32767
#                              Default: 10050
#                              Type: integer
#
#   $load_module               Type: string
#
#   $load_module_path          Type: string
#
#   $log_file_size             Range: 0-1024
#                              Type: integer
#
#   $log_file                  The full path to where Zabbix should store it's
#                              logs.
#                              Default: 'C:\zabbix_agentd.log' OR
#                                       '/var/log/zabbix/zabbix_agentd.log'
#                              Type: string
#
#   $log_remote_commands       0 - disabled, 1 - enabled
#                              Type: integer
#
#   $max_lines_per_second      Range: 1-1000
#                              Type: integer
#
#   $perf_counter              Each item should be formmated as follows:
#                              <parameter_name>,"<perf_counter_path>",<period>
#                              Type: array
#
#   $pid_file                  Name of PID file.
#                              Type: string
#
#   $refresh_active_checks     Range: 60-3600
#                              Type: integer
#
#   $server                    Default: '127.0.0.1'
#                              Type: String separated by commas OR Array
#
#   $server_active             Default: '127.0.0.1'
#                              Type: String separated by commas OR Array
#
#   $source_ip                 Source IP address for outgoing connections.
#                              Type: string, formatted as an IP address
#
#   $start_agents              Range: 0-100
#                              Type: integer
#
#   $timeout                   Range: 1-30
#                              Type: integer
#
#   $unsafe_user_parameters    0 - do not allow, 1 - allow
#
#   $user_parameter            User-defined parameter to monitor.
#                              Type: array
#
#   $user                      Drop privileges to a specific, existing user on
#                              the system.
#                              Type: string
#
#
# Requires: see metadata.json
#
# Sample Usage: see README.md
#
class zabbixagent (
  # depreciated vars
  $include_dir            = undef,
  $include_file           = undef,
  $logfile                = undef,
  $servers                = undef,
  $servers_active         = undef,

  # preinstall settings
  $manage_repo_epel       = $::zabbixagent::params::manage_repo_epel,
  $manage_repo_zabbix     = $::zabbixagent::params::manage_repo_zabbix,

  # conf settings
  $config_dir             = $::zabbixagent::params::config_dir,

  # install setting
  $ensure_setting         = $::zabbixagent::params::ensure_setting,
  $custom_require_linux   = $::zabbixagent::params::custom_require_linux,
  $custom_require_windows = $::zabbixagent::params::custom_require_windows,

  # config file settings
  $allow_root             = $::zabbixagent::params::allow_root,
  $buffer_send            = $::zabbixagent::params::buffer_send,
  $buffer_size            = $::zabbixagent::params::buffer_size,
  $debug_level            = $::zabbixagent::params::debug_level,
  $enable_remote_commands = $::zabbixagent::params::enable_remote_commands,
  $host_metadata          = $::zabbixagent::params::host_metadata,
  $host_metadata_item     = $::zabbixagent::params::host_metadata_item,
  $hostname               = $::zabbixagent::params::hostname,
  $hostname_item          = $::zabbixagent::params::hostname_item,
  $include_files          = $::zabbixagent::params::include_files,
  $item_alias             = $::zabbixagent::params::item_alias,
  $listen_ip              = $::zabbixagent::params::listen_ip,
  $listen_port            = $::zabbixagent::params::listen_port,
  $load_module            = $::zabbixagent::params::load_module,
  $load_module_path       = $::zabbixagent::params::load_module_path,
  $log_file               = $::zabbixagent::params::log_file,
  $log_file_size          = $::zabbixagent::params::log_file_size,
  $log_remote_commands    = $::zabbixagent::params::log_remote_commands,
  $max_lines_per_second   = $::zabbixagent::params::max_lines_per_second,
  $perf_counter           = $::zabbixagent::params::perf_counter,
  $pid_file               = $::zabbixagent::params::pid_file,
  $refresh_active_checks  = $::zabbixagent::params::refresh_active_checks,
  $server                 = $::zabbixagent::params::server,
  $server_active          = $::zabbixagent::params::server_active,
  $source_ip              = $::zabbixagent::params::source_ip,
  $start_agents           = $::zabbixagent::params::start_agents,
  $timeout                = $::zabbixagent::params::timeout,
  $unsafe_user_parameters = $::zabbixagent::params::unsafe_user_parameters,
  $user_parameter         = $::zabbixagent::params::user_parameter,
  $user                   = $::zabbixagent::params::user,
) inherits ::zabbixagent::params {
  # lint:ignore:80chars
  # these should not be used as they are pre v2.1
  $depreciation_msg = 'was removed in v2.1. Please update your manifests and/or hiera data.'
  # lint:endignore

  if ($include_dir) {
    fail("\$include_dir ${depreciation_msg}")
  }

  if ($include_file) {
    fail("\$include_file ${depreciation_msg}")
  }

  if ($logfile) {
    fail("\$logfile ${depreciation_msg}")
  }

  if ($servers) {
    fail("\$servers ${depreciation_msg}")
  }

  if ($servers_active) {
    fail("\$servers_active ${depreciation_msg}")
  }

  # validate booleans
  validate_bool($manage_repo_epel)
  validate_bool($manage_repo_zabbix)

  # validate strings
  validate_string($ensure_setting)
  validate_string($hostname)

  if (!(is_string($server) or is_array($server))) {
    fail('$servers must be either a string or an array')
  }

  if (!(is_string($server_active) or is_array($server_active))) {
    fail('$servers_active must be either a string or an array')
  }

  anchor { '::zabbixagent::start':
  } ->
  class { '::zabbixagent::preinstall':
  } ->
  class { '::zabbixagent::install':
  } ->
  class { '::zabbixagent::config':
  } ->
  class { '::zabbixagent::service':
  } ->
  anchor { '::zabbixagent::end':
  }

}

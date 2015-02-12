# Class: zabbixagent
#
# This module manages the zabbix agent on a monitored machine.
#
# Parameters:
#   $ensure_setting     Passed directly to ensure of package resource
#                       Default: 'present'
#
#   $hostname           The hostname used in the config file.
#                       Default: downcase($::fqdn)
#
#   $include_dir        The directory that additional config files will be
#                       placed in.
#                       Default: 'zabbix_agentd.d'
#                       Type: String
#
#   $include_file       A file that that contain additional settings
#                       Default: ''
#                       Type: String
#
#   $logfile            The full path to where Zabbix should store it's logs.
#                       Default: 'C:\zabbix_agentd.log'
#                       Type: String
#
#   $manage_repo_epel   Determines if the EPEL repo is managed on the RedHat
#                       family of OS's.
#                       Default: false
#                       Type: boolean
#
#   $manage_repo_zabbix Determines if the Zabbix repo is managed on the RedHat
#                       family of OS's.
#                       Default: false
#                       Type: boolean
#
#   $servers            The server or servers used in the Servers setting.
#                       Default: '127.0.0.1'
#                       Type: String separated by commas OR Array
#
#   $servers_active     The server or servers used in the Servers setting.
#                       Default: '127.0.0.1'
#                       Type: String separated by commas OR Array
#
#
# Requires: see metadata.json
#
# Sample Usage:
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

  # install setting
  $ensure_setting         = $::zabbixagent::params::ensure_setting,

  # config file settings
  $allow_root             = $::zabbixagent::params::allow_root,
  $buffer_send            = $::zabbixagent::params::buffer_send,
  $buffer_size            = $::zabbixagent::params::buffer_size,
  $debug_level            = $::zabbixagent::params::debug_level,
  $enable_remote_commands = $::zabbixagent::params::enable_remote_commands,
  $host_metadata_item     = $::zabbixagent::params::host_metadata_item,
  $host_metadata          = $::zabbixagent::params::host_metadata,
  $hostname_item          = $::zabbixagent::params::hostname_item,
  $hostname               = $::zabbixagent::params::hostname,
  $include                = $::zabbixagent::params::include,
  $item_alias             = $::zabbixagent::params::item_alias,
  $listen_ip              = $::zabbixagent::params::listen_ip,
  $listen_port            = $::zabbixagent::params::listen_port,
  $load_module_path       = $::zabbixagent::params::load_module_path,
  $load_module            = $::zabbixagent::params::load_module,
  $log_file_size          = $::zabbixagent::params::log_file_size,
  $log_file               = $::zabbixagent::params::log_file,
  $log_remote_commands    = $::zabbixagent::params::log_remote_commands,
  $max_lines_per_second   = $::zabbixagent::params::max_lines_per_second,
  $perf_counter           = $::zabbixagent::params::perf_counter,
  $pid_file               = $::zabbixagent::params::pid_file,
  $refresh_active_checks  = $::zabbixagent::params::refresh_active_checks,
  $server_active          = $::zabbixagent::params::server_active,
  $server                 = $::zabbixagent::params::server,
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

  class { '::zabbixagent::preinstall':
  } ->
  class { '::zabbixagent::install':
  } ->
  class { '::zabbixagent::config':
  } ->
  class { '::zabbixagent::service':
  }

}

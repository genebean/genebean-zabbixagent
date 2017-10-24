# Class: zabbixagent
#
# This module manages the zabbix agent on a monitored machine.
#
# Unless listed otherwise below, all settings in zabbix_agentd.conf are
# ommitted unless a value is passed in. In the config file, setting names are
# capitalized and run together. Here, they share the same name but are lower
# case and have an underscore separating words. Ex: PidFile becomes pid_file.
#
# 
# #### Preinstall
#
# **manage_repo_epel**
# Determines if the EPEL repo is managed on the RedHat family of OS's.
# Default: false
# Type: boolean
#
# **manage_repo_zabbix**
# Determines if the Zabbix repo is managed on the RedHat family of OS's.
# Default: false
# Type: boolean
#
#
# #### Install
#
# **custom_require_linux**
# Passed directly to require of package resource when on Linux
# Default: undef
#
# **custom_require_windows**
# Passed directly to require of package resource when on Windows
# Default: undef
#
# **ensure_setting**
# Passed directly to ensure of package resource
# Default: 'present'
#
#
# #### Config
#
# **allow_root**
# 0 - do not allow, 1 - allow
# Type: integer
#
# **buffer_send**
# Range: 1-3600
# Type: integer
#
# **buffer_size**
# Range: 2-65535
# Type: integer
#
# **config_dir**
# Defines the directory in which config files live
# Default on Linux:   '/etc/zabbix'
# Default on Windows: 'C:/ProgramData/zabbix'
#
# **debug_level**
# Range: 0-4
# Type: integer
#
# **enable_remote_commands**
# 0 - not allowed, 1 - allowed
# Type: integer
#
# **host_metadata**
# Range: 0-255 characters
# Type: string
#
# **host_metadata_item**
# Parameter that defines an item used for getting host metadata used during host
# auto-registration process.
# To disable, set to ''.
# Default: 'system.uname'
#
# **hostname**
# The hostname used in the config file.
# Default: downcase($::fqdn)
#
# **hostname_item**
# An item to be used for determining a host's name
#
# **include_files**
# Equates to include in zabbix_agentd.conf. Renamed due to include being special
# in Puppet. An array with one or more files to be included in the config.
# On non-Windows systems, this can be a folder or a path with a wildcard. See
# zabbix_agentd.conf for details.
# Type: array
#
# **item_alias**
# Equates to alias in zabbix_agentd.conf. Renamed due to alias being the name of
# a Puppet metaparameter. Sets an alias for an item key.
# Type: array
#
# **listen_ip**
# List of comma delimited IP addresses that the agent should listen on.
# Type: string
#
# **listen_port**
# Range: 1024-32767
# Default: 10050
# Type: integer
#
# **load_module**
# Type: string
#
# **load_module_path**
# Type: string
#
# **log_file_size**
# Range: 0-1024
# Type: integer
#
# **log_file**
# The full path to where Zabbix should store it's logs.
# Default on Windows: 'C:\zabbix_agentd.log'
# Default on Linux: '/var/log/zabbix/zabbix_agentd.log'
# Type: string
#
# **log_type**
# Log output type.
# Type: string
#
# **log_remote_commands**
# 0 - disabled, 1 - enabled
# Type: integer
#
# **max_lines_per_second**
# Range: 1-1000
# Type: integer
#
# **package_name**
# Name of the Zabbix Agent package.
# The default values for this can be found in params.pp as it is OS dependent.
# Type: string
#
# **perf_counter**
# Each item should be formmated as follows:
# <parameter_name>,"<perf_counter_path>",<period>
# Type: array
#
# **pid_file**
# Name of PID file.
# Type: string
#
# **refresh_active_checks**
# Range: 60-3600
# Type: integer
#
# **server**
# Default: '127.0.0.1'
# Type: String separated by commas OR Array
#
# **server_active**
# Default: '127.0.0.1'
# Type: String separated by commas OR Array
#
# **source_ip**
# Source IP address for outgoing connections.
# Type: string, formatted as an IP address
#
# **start_agents**
# Range: 0-100
# Type: integer
#
# **timeout**
# Range: 1-30
# Type: integer
#
# **tls_accept**
# What incoming connections to accept.
# Type: String separated by commas OR Array
#
# **tls_ca_file**
# Full pathname of a file containing the top-level CA(s) certificates for peer
# certificate verification.
# Type: String
#
# **tls_cert_file**
# Full pathname of a file containing the agent certificate or certificate chain.
# Type: String
#
# **tls_connect**
# How the agent should connect to server or proxy.
# Type: String
#
# **tls_crl_file**
# Full pathname of a file containing revoked certificates.
# Type: String
#
# **tls_key_file**
# Full pathname of a file containing the agent private key.
# Type: String
#
# **tls_psk_file**
# Full pathname of a file containing the agent pre-shared key.
# Type: String
#
# **tls_psk_identity**
# Pre-shared key identity string.
# Type: String
#
# **tls_server_cert_issuer**
# Allowed server (proxy) certificate issuer.
# Type: String
#
# **tls_server_cert_subject**
# Allowed server (proxy) certificate subject.
# Type: String
#
# **unsafe_user_parameters**
# 0 - do not allow, 1 - allow
#
# **user_parameter**
# User-defined parameter to monitor.
# Type: array
#
# **user**
# Drop privileges to a specific, existing user on the system.
# Type: string
#
# **version**
# Determines what version of the Zabbix Agent to install.
# Default: '3.2'
# Allowed values: '3.2', '3.0', or '2.4'
# Type: string
#
# Sample Usage: see README.md
#
class zabbixagent (
  # depreciated vars
  $include_dir,
  $include_file,
  $logfile,
  $servers,
  $servers_active,

  # preinstall settings
  $manage_repo_epel,
  $manage_repo_zabbix,

  # conf settings
  $config_dir,

  # install setting
  $ensure_setting,
  $custom_require_linux,
  $custom_require_windows,

  # config file settings
  $allow_root,
  $buffer_send,
  $buffer_size,
  $debug_level,
  $enable_remote_commands,
  $host_metadata,
  $host_metadata_item,
  $hostname,
  $hostname_item,
  $include_files,
  $item_alias,
  $listen_ip,
  $listen_port,
  $load_module,
  $load_module_path,
  $log_file,
  $log_file_size,
  $log_remote_commands,
  $log_type,
  $max_lines_per_second,
  $package_name,
  $perf_counter,
  $pid_file,
  $refresh_active_checks,
  $server,
  $server_active,
  $source_ip,
  $start_agents,
  $timeout,
  $tls_accept,
  $tls_ca_file,
  $tls_cert_file,
  $tls_connect,
  $tls_crl_file,
  $tls_key_file,
  $tls_psk_file,
  $tls_psk_identity,
  $tls_server_cert_issuer,
  $tls_server_cert_subject,
  $unsafe_user_parameters,
  $user_parameter,
  $user,
  $version,
  $service_name,
  $config_name,
) {
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

  if !($version in [ '2.4', '3.0', '3.2' ]) {
    fail("Zabbix ${version} is not supported but PR's are welcome.")
  }

  if ($version == '2.4' and ($log_type)) {
    fail('The parameter log_type is only supported since Zabbix 3.0.')
  }

  if ($version == '2.4' and ($tls_accept)) {
    fail('The parameter tls_accept is only supported since Zabbix 3.0.')
  }

  if ($version == '2.4' and ($tls_ca_file)) {
    fail('The parameter tls_ca_file is only supported since Zabbix 3.0.')
  }

  if ($version == '2.4' and ($tls_cert_file)) {
    fail('The parameter tls_cert_file is only supported since Zabbix 3.0.')
  }

  if ($version == '2.4' and ($tls_connect)) {
    fail('The parameter tls_connect is only supported since Zabbix 3.0.')
  }

  if ($version == '2.4' and ($tls_crl_file)) {
    fail('The parameter tls_crl_file is only supported since Zabbix 3.0.')
  }

  if ($version == '2.4' and ($tls_key_file)) {
    fail('The parameter tls_key_file is only supported since Zabbix 3.0.')
  }

  if ($version == '2.4' and ($tls_psk_file)) {
    fail('The parameter tls_psk_file is only supported since Zabbix 3.0.')
  }

  if ($version == '2.4' and ($tls_psk_identity)) {
    fail('The parameter tls_psk_identity is only supported since Zabbix 3.0.')
  }

  if ($version == '2.4' and ($tls_server_cert_issuer)) {
    fail('The parameter tls_server_cert_issuer is only supported since Zabbix 3.0.') # lint:ignore:80chars
  }

  if ($version == '2.4' and ($tls_server_cert_subject)) {
    fail('The parameter tls_server_cert_subject is only supported since Zabbix 3.0.') # lint:ignore:80chars
  }

  contain ::zabbixagent::preinstall
  contain ::zabbixagent::install
  contain ::zabbixagent::config
  contain ::zabbixagent::service

  Class['::zabbixagent::preinstall']
  -> Class['::zabbixagent::install']
  -> Class['::zabbixagent::config']
  ~> Class['::zabbixagent::service']
}

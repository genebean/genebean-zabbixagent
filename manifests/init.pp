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
# A class name to require before the zabbix agent package is installed on Linux.
# The named class will also be included.
# Default: undef
#
# **custom_require_windows**
# A class name to require before the zabbix agent package is installed on Windows.
# The named class will also be included.
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
# Default: downcase($fqdn)
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
  # preinstall settings
  Boolean $manage_repo_epel        = false,
  Boolean $manage_repo_zabbix      = false,

  # conf settings
  Stdlib::Absolutepath $config_dir              = $zabbixagent::params::config_dir,

  # install setting
  String[1] $ensure_setting                       = 'present',
  Optional[String[1]] $custom_require_linux       = undef,
  Optional[String[1]] $custom_require_windows     = undef,

  # config file settings
  Optional[Integer[0,1]] $allow_root              = undef,
  Optional[Integer] $buffer_send                  = undef,
  Optional[Integer] $buffer_size                  = undef,
  Optional[Integer[0,5]] $debug_level             = undef,
  Optional[Integer[0,1]] $enable_remote_commands  = undef,
  Optional[String[1,255]] $host_metadata          = undef,
  String[1,255] $host_metadata_item               = 'system.uname',
  String[1] $hostname                             = downcase($facts['networking']['fqdn']),
  Optional[String[1]] $hostname_item              = undef,
  Optional[Array[String[1]]] $include_files       = $zabbixagent::params::include_files,
  $item_alias              = $zabbixagent::params::item_alias,
  $listen_ip               = $zabbixagent::params::listen_ip,
  $listen_port             = $zabbixagent::params::listen_port,
  $load_module             = $zabbixagent::params::load_module,
  $load_module_path        = $zabbixagent::params::load_module_path,
  $log_file                = $zabbixagent::params::log_file,
  $log_file_size           = $zabbixagent::params::log_file_size,
  $log_remote_commands     = $zabbixagent::params::log_remote_commands,
  $log_type                = $zabbixagent::params::log_type,
  $max_lines_per_second    = $zabbixagent::params::max_lines_per_second,
  $package_name            = 'zabbix-agent',
  $perf_counter            = $zabbixagent::params::perf_counter,
  $pid_file                = $zabbixagent::params::pid_file,
  $refresh_active_checks   = $zabbixagent::params::refresh_active_checks,
  Variant[String[1], Array[String[1]]] $server                  = '127.0.0.1',
  Variant[String[1], Array[String[1]]] $server_active           = '127.0.0.1',
  $source_ip               = $zabbixagent::params::source_ip,
  $start_agents            = $zabbixagent::params::start_agents,
  $timeout                 = $zabbixagent::params::timeout,
  $tls_accept              = $zabbixagent::params::tls_accept,
  $tls_ca_file             = $zabbixagent::params::tls_ca_file,
  $tls_cert_file           = $zabbixagent::params::tls_cert_file,
  $tls_connect             = $zabbixagent::params::tls_connect,
  $tls_crl_file            = $zabbixagent::params::tls_crl_file,
  $tls_key_file            = $zabbixagent::params::tls_key_file,
  $tls_psk_file            = $zabbixagent::params::tls_psk_file,
  $tls_psk_identity        = $zabbixagent::params::tls_psk_identity,
  $tls_server_cert_issuer  = $zabbixagent::params::tls_server_cert_issuer,
  $tls_server_cert_subject = $zabbixagent::params::tls_server_cert_subject,
  $unsafe_user_parameters  = $zabbixagent::params::unsafe_user_parameters,
  $user_parameter          = $zabbixagent::params::user_parameter,
  $user                    = $zabbixagent::params::user,
  $version                 = $zabbixagent::params::version,
) inherits zabbixagent::params {
  if (versioncmp($version, '3.0') < 0) {
    fail("Zabbix ${version} is not supported but PR's are welcome.")
  }

  contain zabbixagent::preinstall
  contain zabbixagent::install
  contain zabbixagent::config
  contain zabbixagent::service

  anchor { 'zabbixagent::start': }
  -> Class['zabbixagent::preinstall']
  -> Class['zabbixagent::install']
  -> Class['zabbixagent::config']
  -> Class['zabbixagent::service']
  -> anchor { 'zabbixagent::end': }

}

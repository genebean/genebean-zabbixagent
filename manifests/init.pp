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
  # conf settings
  Stdlib::Absolutepath $config_dir,

  # preinstall settings
  Boolean $manage_repo_epel                         = false,
  Boolean $manage_repo_zabbix                       = false,

  # install setting
  String[1] $ensure_setting                         = 'present',
  Optional[String[1]] $custom_require_linux         = undef,
  Optional[String[1]] $custom_require_windows       = undef,

  # config file settings
  Optional[Integer[0,1]] $allow_root                = undef,
  Optional[Integer[1,3600]] $buffer_send            = undef,
  Optional[Integer[2,65535]] $buffer_size           = undef,
  Optional[Integer[0,5]] $debug_level               = undef,
  Optional[Integer[0,1]] $enable_remote_commands    = undef,
  Optional[String[1,255]] $host_metadata            = undef,
  String[1,255] $host_metadata_item                 = 'system.uname',
  String[1] $hostname                               = downcase($facts['networking']['fqdn']),
  Optional[String[1]] $hostname_item                = undef,
  Optional[Array[String[1]]] $include_files         = undef,
  Optional[String[1]] $item_alias                   = undef,
  Optional[Array[Stdlib::IP::Address]] $listen_ip   = undef,
  Optional[Integer[1024,32767]] $listen_port        = undef,
  Optional[Array[String[1]]] $load_module           = undef,
  Optional[Stdlib::Absolutepath] $load_module_path  = undef,
  Optional[Stdlib::Absolutepath] $log_file          = undef,
  Optional[Integer[0,1024]] $log_file_size          = undef,
  Optional[Integer[0,1]] $log_remote_commands       = undef,
  Optional[Zabbixagent::Logtype] $log_type          = undef,
  Optional[Integer[1,1000]] $max_lines_per_second   = undef,
  String[1] $package_name                           = 'zabbix-agent',
  Optional[String[1]] $perf_counter                 = undef,
  Optional[Stdlib::Absolutepath] $pid_file          = undef,
  Optional[Integer[60,3600]] $refresh_active_checks = undef,
  Zabbixagent::Server $server                       = '127.0.0.1',
  Zabbixagent::Server $server_active                = '127.0.0.1',
  Optional[Stdlib::IP::Address] $source_ip          = undef,
  Optional[Integer[0,100]] $start_agents            = undef,
  Optional[Integer[1,30]] $timeout                  = undef,
  Optional[Zabbixagent::Tls::Accept] $tls_accept    = undef,
  Optional[Stdlib::Absolutepath] $tls_ca_file       = undef,
  Optional[Stdlib::Absolutepath] $tls_cert_file     = undef,
  Optional[Zabbixagent::Tls::Connect] $tls_connect  = undef,
  Optional[Stdlib::Absolutepath] $tls_crl_file      = undef,
  Optional[Stdlib::Absolutepath] $tls_key_file      = undef,
  Optional[Stdlib::Absolutepath] $tls_psk_file      = undef,
  Optional[String[1]] $tls_psk_identity             = undef,
  Optional[String[1]] $tls_server_cert_issuer       = undef,
  Optional[String[1]] $tls_server_cert_subject      = undef,
  Optional[Integer[0,1]] $unsafe_user_parameters    = undef,
  Optional[Array[String[1]]] $user_parameter        = undef,
  Optional[String[1]] $user                         = undef,
  Regexp[/\d+\.\d+/] $version                       = '4.4',
) {
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

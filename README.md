[![Build Status][travis-img-master]][travis-ci]
[![Puppet Forge][pf-img]][pf-link]
[![GitHub tag][gh-tag-img]][gh-link]

# Zabbix Agent Puppet Module


#### Table of Contents

1. [Overview](#overview)
2. [Setup requirements](#setup-requirements)
3. [Parameters](#parameters)
4. [Usage](#usage)
5. [Contributing](#contributing)
6. [Contributors](#contributors)
7. [License](#license)


## Overview

This module manages the zabbix agent for a monitored machine. It can
also, optionally, manage repositories related to Zabbix on Linux. On the Red Hat
family of OS's, this includes both EPEL and Zabbix. On the Debian family,
this is just the Zabbix repo. On SUSE this is the "Server Monitoring Software"
repo. On Windows this module utilizes the [Chocolatey][chocolatey] provider.


## Setup Requirements

This module has been tested against Puppet 3.8.7 on:
* CentOS 6 & 7
* OpenSUSE Leap 42.1
* Red Hat 5, 6, 7
* SUSE Linux Enterprise Server 12
* Ubuntu Server 14.04
* Windows 7
* Windows Server 2012 R2

Testing via Travis-CI is also done against Puppet 3.x using future parser and against
Puppet 4.x using strict variables.


## Parameters:

#### Depreciated options  
These options were removed in v2.1.0. If they exist in your
manifests or hiera data they will cause a compilation failure.

```puppet
$include_dir
$include_file
$logfile
$servers
$servers_active
```


#### preinstall.pp settings

#####`manage_repo_epel`  
Determines if the EPEL repo is managed on the RedHat family of OS's.  
Default: false  
Type: boolean

#####`manage_repo_zabbix`  
Determines if the Zabbix repo is managed on the RedHat family of OS's.  
Default: false  
Type: boolean


#### install.pp settings

#####`ensure_setting`  
Passed directly to ensure of package resource  
Default: 'present'

#####`custom_require_linux`  
Passed directly to require of package resource when on Linux  
Default: undef

#####`custom_require_windows`  
Passed directly to require of package resource when on Windows  
Default: undef


#### config.pp settings

#####`allow_root`  
0 - do not allow, 1 - allow  
Type: integer

#####`buffer_send`  
Range: 1-3600  
Type: integer

#####`buffer_size`  
Range: 2-65535  
Type: integer

#####`config_dir`  
Defines the directory in which config files live  
Default: '/etc/zabbix' on Linux, 'C:/ProgramData/zabbix' on Windows  

#####`debug_level`  
Range: 0-4  
Type: integer

#####`enable_remote_commands`  
0 - not allowed, 1 - allowed  
Type: integer

#####`host_metadata`  
Range: 0-255 characters  
Type: string

#####`host_metadata_item`  
Parameter that defines an item used for getting host metadata used during host
auto-registration process. To disable, set to ''.  
Default: 'system.uname'

#####`hostname`  
The hostname used in the config file.  
Default: downcase($::fqdn)

#####`hostname_item`  
An item to be used for determining a host's name  

#####`include_files`  
Equates to include in zabbix_agentd.conf. Renamed due to include being special in
Puppet. An array with one or more files to be included in the config. On non-Windows
systems, this can be a folder or a path with a wildcard. See zabbix_agentd.conf for details.  
Type: array

#####`item_alias`  
Equates to alias in zabbix_agentd.conf. Renamed due to `alias` being the name of a
Puppet metaparameter. Sets an alias for an item key.  
Type: array

#####`listen_ip`  
List of comma delimited IP addresses that the agent should listen on.  
Type: string

#####`listen_port`  
Range: 1024-32767  
Default: 10050  
Type: integer

#####`load_module`  
Type: string

#####`load_module_path`  
Type: string

#####`log_file_size`  
Range: 0-1024  
Type: integer

#####`log_file`  
The full path to where Zabbix should store it's logs.  
Default: 'C:\zabbix_agentd.log' OR '/var/log/zabbix/zabbix_agentd.log'  
Type: string

#####`log_remote_commands`  
0 - disabled, 1 - enabled  
Type: integer

#####`max_lines_per_second`  
Range: 1-1000  
Type: integer

#####`perf_counter`  
Each item should be formated as follows:  
`<parameter_name>,"<perf_counter_path>",<period>`  
Type: array

#####`pid_file`  
Name of PID file.  
Type: string

#####`refresh_active_checks`  
Range: 60-3600  
Type: integer

#####`server`  
Default: '127.0.0.1'  
Type: String separated by commas OR Array

#####`server_active`  
Default: '127.0.0.1'  
Type: String separated by commas OR Array

#####`source_ip`  
Source IP address for outgoing connections.  
Type: string, formatted as an IP address

#####`start_agents`  
Range: 0-100  
Type: integer

#####`timeout`  
Range: 1-30  
Type: integer

#####`unsafe_user_parameters`  
0 - do not allow, 1 - allow

#####`user_parameter`  
User-defined parameter to monitor.  
Type: array

#####`user`  
Drop privileges to a specific, existing user on the system.  
Type: string


## Usage

```puppet
class { 'zabbixagent':
  ensure_setting => 'latest',
  include_files  => ['/etc/zabbix_agentd.conf.d/userparams.conf',],
  log_file_size  => 0,
  server         => 'zabbix.example.com,offsite.example.com',
  server_active  => ['zabbix.example.com', 'offiste.example.com',],
}
```

All parameters available in `zabbix_agentd.conf` should be listed above. Please submit
a bug report if you find this not to be the case and it will be added.


## Contributing

Pull requests, bug reports, and enhancement requests are welcome! Enhancement
requests should be filed just like other issues.


## Contributors

* Scott Smerchek (@smerchek) - Author of [softek-zabbixagent][pf-softek-zabbixagent]
* Martijn Storck (@martijn)  - Added CentOS support
* Simonas Rup�ys (@simonasr) - Changed case syntax to work on Puppet 4.x
* Jake Spain (@thespain) - Added support for SUSE Enterprise and OpenSUSE Leap


## License

This is released under the New BSD / BSD 3 Clause license. A copy of the license
can be found in the root of the module.


### History

This was originally [softek-zabbixagent][pf-softek-zabbixagent] before undergoing
a total rewrite in January 2015. Post rewrite, only a couple of comments and part of
one line of the original code was left. Since no 'substantial portions' of the code
was reused and no written licence was contained in the repository I have chosen not
to reuse the MIT license that was referenced in the original metadata.json file.

This module has been released independant of the original after reviewing the
original author's GitHub issue tracker. Specifically, it appeared that they had
not been responding to issues or pull requests for at least six months and some
had sat for nearly two years. This response timeframe and my needs didn't line
up so here we are.

[chocolatey]: https://chocolatey.org
[coveralls-master]: https://coveralls.io/r/genebean/genebean-zabbixagent?branch=master
[coveralls-img-master]: https://img.shields.io/coveralls/genebean/genebean-zabbixagent/master.svg
[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-zabbixagent.svg
[gh-link]: https://github.com/genebean/genebean-zabbixagent
[pf-img]: https://img.shields.io/puppetforge/v/genebean/zabbixagent.svg
[pf-link]: https://forge.puppetlabs.com/genebean/zabbixagent
[pf-softek-zabbixagent]: https://forge.puppetlabs.com/softek/zabbixagent
[travis-ci]: https://travis-ci.org/genebean/genebean-zabbixagent
[travis-img-master]: https://img.shields.io/travis/genebean/genebean-zabbixagent/master.svg

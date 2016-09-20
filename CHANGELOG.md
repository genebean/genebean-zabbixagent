[![GitHub tag][gh-tag-img]][gh-link]

## 2016-09-20 Release 2.6.0  
- Added support for OpenSUSE Leap (thanks to Jake Spain)

## 2016-08-15 Release 2.5.0  
- Added support for SUSE Enterprise (thanks to Jake Spain)

## 2015-07-14 Release 2.4.1  
- Fixed copy/paste fail in .travis.yml

## 2015-07-14 Release 2.4.0  
- Updates to support Puppet 4

## 2015-05-28 Release 2.3.0  
- Updated default configuration directory on Windows to be 'C:/ProgramData/zabbix'
  as that is the default in the current Chocolatey package.
- Switched to the new official Chocolatey module

## 2015-03-02 Release 2.2.0  
- Added the ability to define a require on the package resource

## 2015-02-27 Release 2.1.1  
- Updated Gemfile to use rspec-puppet v2.0 instead of git master
- Added default value for PidFile due to Zabbix's default being /run

## 2015-02-12 Release 2.1.0  
- Transitioned to a fully templated zabbix_agentd.conf
- Added code to fail compilation if depreciated variables exists
- Added more tests

## 2015-01-25 Release 2.0.7  
- Fixed validation
- Added new tests for Servers and ServersActive settings

## 2015-01-25 Release 2.0.6  
- Updated Vagrantfile
- Fixed rspec settings so that details are shown

## 2015-01-25 Release 2.0.5  
- Added puppet_blacksmith for packaging

## 2015-01-25 Release 2.0.4  
- Cleaned up formatting

## 2015-01-25 Release 2.0.3  
- Moved exec's in preinstall.pp inside osfamily case statement

## 2015-01-19 Release 2.0.2  
- Reformatted this file

## 2015-01-19 Release 2.0.1  
- Fixed some spelling and a link in the README.md file

## 2015-01-17 Fork - Release 2.0.0  
### Total Rework by genebean:  
- Converted to use the install -> config -> service pattern
- Moved all parameters to `params.pp`
- Removed dependency on epel module
- Added Zabbix repo
- Added option to disable repo management per repo
- Changed Windows setup to utilize the official Zabbix package via Chocolatey
- Added .project file for Geppetto
- Added Vagrant config to facilitate testing and development
- Added several new parameters (see changes to README.md)

## 2014-07-15 Release 1.0.1  
### Changes:  
- Upgrade package format and fix deprecation warnings.

## 2013-02-18 Release 1.0.0  
### Breaking Changes:  
- Default hostname is now `$::fqdn` instead of `$::hostname`

### Changes:  
- Added CentOS support (by @martijn)

### Bugfixes:  
- Added restarting of the zabbix-agent service when a setting is changed (#3)
- Fix dependency issues between package, service, and ini_settings (#4)

## 2013-01-02 Release 0.1.0  
### Changes:  
- Use ini_setting module to only change necessary settings rather than use
the entire config file as a template. This will insulate us from changes in the
Zabbix configuration with new versions.
- Other fixes

[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-zabbixagent.svg?label=newest%20tag
[gh-link]: https://github.com/genebean/genebean-zabbixagent

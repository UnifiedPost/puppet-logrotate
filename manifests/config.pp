# = Class: logrotate::config
#
# Perform initial configuration.
#
# == Parameters:
#
# $rotation_interval::  Global rotation interval (daily, weekly, ...)
#
# $retention_period::   Retention period.
#
# === Advanced configuration:
#
# Normally you will not have to touch these. In case you have a funky setup
# (custom package?) you can override these additional parameters:
#
# $confdir::    Directory where additional logrotation configuration is placed.
#
# $conffile::   Main logrotate configuration file.
#
# == Actions:
#
# This will make sure that the configuration directory and file exist and
# initialize the configuration file with some settings.
#
# == Requires:
#
# A logrotate package should be installed. If the package has another name,
# make sure to alias it:
#
#     package {'custom-logrotate':
#       ensure => 'installed',
#       alias => 'logrotate',
#     }
#
# == Todo:
#
# TODO: Update documentation
#
class logrotate::config (
  $confdir  = $::logrotate::params::conf_dir,
  $conffile = $::logrotate::params::conf_file,
  $rotation_interval = $::logrotate::params::rotation_interval,
  $retention_period =  $::logrotate::params::retention_period
) inherits logrotate::params {

  File {
    require => Package['logrotate'],
  }

  file { 'logrotate.d':
    ensure => 'directory',
    path   => $confdir,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file {'logrotate.conf':
    ensure  => 'present',
    path    => $conffile,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('logrotate/logrotate.conf.erb'),
  }

}

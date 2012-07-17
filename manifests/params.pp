# = Class: logrotate::params
#
# A place for global defaults and/or distro specific configuration
#
# == Parameters:
#
# $package::            Override the package name to be installed.
#                       Defaults to distro-specific or 'logrotate'.
#
# $confdir::            Override the logrotation directory.
#                       Defaults to distro-specific or '/etc/logrotate.d'.
#
# $conffile::           Override the default main configuration file.
#                       Defaults to distro-specific or '/etc/logrotate.conf'.
#
# $rotation_interval::  The default rotation interval to use. This is
#                       configured in the main configuration file.
#                       Defaults to 'daily'.
#
# $retention_period::   The default retention period to use. This is configured
#                       in the main configuration file.
#                       Defaults to 90.
#
# == Actions:
#
# == Requires:
#
# == Sample Usage:
#
class logrotate::params (
  $package = undef,
  $confdir = undef,
  $conffile = undef,
  $rotation_interval = 'daily',
  $retention_period = 90
) {

  $pkg = $package ? {
    undef   => $::operatingsystem ? {
      /(?i:redhat|centos|fedora)/ => 'logrotate',
      /(?i:debian|ubuntu)/        => 'logrotate',
      default                     => 'logrotate',
    },
    default => $package,
  }
  $conf_dir = $confdir ? {
    undef   => $::operatingsystem ? {
      /(?i:redhat|centos|fedora)/ => '/etc/logrotate.d',
      /(?i:debian|ubuntu)/        => '/etc/logrotate.d',
      default                     => '/etc/logrotate.d',
    },
    default => $confdir,
  }

  $conf_file = $conffile ? {
    undef   => $::operatingsystem ? {
      /(?i:redhat|centos|fedora)/ => '/etc/logrotate.conf',
      /(?i:debian|ubuntu)/        => '/etc/logrotate.conf',
      default                     => '/etc/logrotate.conf',
    },
    default => $conffile,
  }

}

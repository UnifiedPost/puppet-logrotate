# = Definition: logrotate::file
#
# == Parameters:
#
# $log::        Array or string which contains paths/patterns to match.
#               This is a required parameter and has no default value.
#
# $ensure::     See the file puppet type for more information.
#
# $path::       Override the location of the configuration file.
#               This is by default the conf_dir.
#               conf_dir can be configured globally in logrotate::params.
#
# $options::    Array or string with options for this logrotation definition.
#               Defaults to [ 'weekly', 'compress', 'rotate 7', 'missingok' ].
#
# $prerotate::  Command(s) to execute before rotation.
#               Defaults to empty (undefined).
#
# $postrotate:: Command(s) to execute after rotation.
#               Defaults to empty (undefined).
#
# == Todo:
#
# TODO: Update documentation (Add an example).
#
define logrotate::file (
  $log,
  $ensure     = 'present',
  $path       = "${::logrotate::params::conf_dir}",
  $options    = [ 'weekly', 'compress', 'rotate 7', 'missingok' ],
  $prerotate  = undef,
  $postrotate = undef
) {

  file { "${path}/${name}":
    ensure  => $present,
    path    => $path,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('logrotate/logrotate.erb'),
    require => Package['logrotate'],
  }
}

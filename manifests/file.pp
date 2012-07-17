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

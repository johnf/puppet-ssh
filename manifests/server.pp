class ssh::server {

  package { 'openssh-server':
    ensure => installed,
  }

  service { 'openssh-server':
    name    => 'ssh',
    pattern => 'sshd',
    enable  => true,
    ensure  => running,
    require => Package['openssh-server'],
  }

  /*
  augeas { '/etc/ssh/sshd_config_disable_root_login':
    context => '/files/etc/ssh/sshd_config',
    changes => 'set PermitRootLogin no',
    notify  => Service['openssh-server'],
    require => Package['openssh-server'],
  }
  */

}

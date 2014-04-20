class ssh::server($disable_root = true) {

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

  $permit_root_login = $disable_root ? { true => 'no', false => 'yes' }
  augeas { '/etc/ssh/sshd_config_disable_root_login':
    context => '/files/etc/ssh/sshd_config',
    changes => "set PermitRootLogin $permit_root_login",
    notify  => Service['openssh-server'],
    require => Package['openssh-server'],
  }

}

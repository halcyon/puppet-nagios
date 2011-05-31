class nagios::files {
  require nagios::dependencies, nagios::mysql

  file { ['/var/log/nagios','/var/log/nagios/spool', '/var/log/nagios/rw',
          '/var/log/nagios/spool/checkresults']:
    ensure  => directory,
    owner   => nagios,
    group   => nagios,
  }

  file { '/var/log/nagios/.ssh':
    ensure  => directory,
    owner   => nagios,
    group   => nagios,
    mode    => 0400,
  }

  file { '/var/log/nagios/.ssh/id_rsa_gemdba':
    source  => "puppet:///modules/nagios/id_rsa",
    owner   => nagios,
    group   => nagios,
    mode    => 0700,
    require => File['/var/log/nagios/.ssh'],
  }

  file { '/var/log/nagios/.ssh/config':
    content => "StrictHostKeyChecking no",
    owner   => nagios,
    group   => nagios,
    require => File['/var/log/nagios/.ssh'],
  }

}

class nagios::configuration {
  require nagios::dependencies, nagios::mysql, nagios::files

  cron { 'clear-nagios-known-hosts':
    command => "rm -f ~/.ssh/known_hosts",
    user    => nagios,
    hour    => 0,
  }

  exec { 'nagios-configs-clone':
    cwd     => "/etc/nagios",
    command => "git clone git://git/sdlc/nagios-configs domain; chown -R nagios:nagios domain",
    unless  => "test -d /etc/nagios/domain",
  }

  exec { 'nagios-disable-localhost':
    cwd     => "/etc/nagios",
    command => "sed -i 's|cfg_file=/etc/nagios/objects/localhost.cfg|#cfg_file=/etc/nagios/objects/localhost.cfg|'\
                /etc/nagios/nagios.cfg",
  }

  exec { 'enable-nagios-configs':
    command => "echo 'cfg_dir=/etc/nagios/domain' >> /etc/nagios/nagios.cfg",
    unless  => "grep 'cfg_dir=/etc/nagios/domain' /etc/nagios/nagios.cfg",
  }

  exec { 'increase-servchecks':
    cwd     => "/etc/nagios/objects",
    command => "sed -i 's/normal_check_interval           10	/normal_check_interval           1	/' templates.cfg",
    unless  => "grep 'normal_check_interval           1	' templates.cfg",
  }

  exec { 'nagios-configs-pull':
    cwd     => "/etc/nagios/domain",
    command => "git pull",
    require => Exec['nagios-configs-clone'],
  }

  exec { 'installdb':
    cwd     => "/usr/share/doc/ndoutils-mysql-1.4/db",
    command => "perl installdb -u dashboard -p dashboard -h localhost -d nagios",
  }

  exec { 'nagios-www-user':
    command => "htpasswd -bcm /etc/nagios/htpasswd.users nagiosadmin nagiosadmin",
    unless => "test -f /etc/nagios/htpasswd.users",
  }

  exec { 'enable-ndo2db-broker':
    command => "echo 'broker_module=/usr/lib64/nagios/brokers/ndomod.so\
    config_file=/etc/nagios/ndomod.cfg' >> /etc/nagios/nagios.cfg",
    unless  => "grep ndomod /etc/nagios/nagios.cfg",
  }

  exec { 'setup-db_user':
    command => "sed -i 's/ndouser/dashboard/' /etc/nagios/ndo2db.cfg",
    unless  => "grep 'db_user=dashboard' /etc/nagios/ndo2db.cfg",
  }

  exec { 'setup-db_pass':
    command => "sed -i 's/ndopassword/dashboard/' /etc/nagios/ndo2db.cfg",
    unless  => "grep 'db_pass=dashboard' /etc/nagios/ndo2db.cfg",
  }

}

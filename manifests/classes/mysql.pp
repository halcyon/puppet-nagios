class nagios::mysql {
  require nagios::dependencies

  include mysql

  mysql::grant{ 'dashboard-localhost':
    mysql_db         => "nagios",
    mysql_user       => "dashboard",
    mysql_password   => "dashboard",
  }

  mysql::grant{ 'dashboard-all':
    mysql_db         => "nagios",
    mysql_user       => "dashboard",
    mysql_host       => "%",
    mysql_password   => "dashboard",
  }

}

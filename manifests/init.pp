class nagios {
  import "classes/*.pp"

  Exec{
    logoutput => true, path => "/usr/bin:/usr/sbin:/bin",
  }

  include nagios::dependencies
  include nagios::mysql
  include nagios::files
  include nagios::configuration
  include nagios::services
}

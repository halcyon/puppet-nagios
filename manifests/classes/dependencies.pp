class nagios::dependencies {

  if ! defined(Package['httpd'])                   { package { 'httpd':                   ensure => latest } }
  if ! defined(Package['php'])                     { package { 'php':                     ensure => latest } }
  if ! defined(Package['nagios'])                  { package { 'nagios':                  ensure => latest } }
  if ! defined(Package['nagios-www'])              { package { 'nagios-www':              ensure => latest } }
  if ! defined(Package['nagios-plugins-1.4.15-1']) { package { 'nagios-plugins-1.4.15-1': ensure => latest } }
  if ! defined(Package['ndoutils'])                { package { 'ndoutils':                ensure => latest } }
  if ! defined(Package['ndoutils-mysql'])          { package { 'ndoutils-mysql':          ensure => latest } }
  if ! defined(Package['git'])                     { package { 'git':                     ensure => latest } }

}

# == Class appinternals::install
#
# This class is called from appinternals for install.
#
class appinternals::install {

  package { $::appinternals::package_name:
    ensure => present,
  }
}

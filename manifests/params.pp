# == Class appinternals::params
#
# This class is meant to be called from appinternals.
# It sets variables according to platform.
#
class appinternals::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'appinternals'
      $service_name = 'appinternals'
    }
    'RedHat', 'Amazon': {
      $package_name = 'appinternals'
      $service_name = 'appinternals'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

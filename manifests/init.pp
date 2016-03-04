# Class: appinternals
# ===========================
#
# Full description of class appinternals here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class appinternals (
  #  $package_name = $::appinternals::params::package_name,
  #$service_name = $::appinternals::params::service_name,
) inherits ::appinternals::params {

  # validate parameters here

  class { '::appinternals::install': } ->
  class { '::appinternals::config': } ~>
  class { '::appinternals::service': } ->
  Class['::appinternals']
}

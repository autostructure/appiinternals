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
  $analysis_server = $::appinternals::params::analysis_server,
) inherits ::appinternals::params {
  # validate parameters here
  unless $analysis_server {
    fail('Analysis server hostname by nodename, FQDN, or ip address is required')
  }

  class { '::appinternals::install': } ->
  class { '::appinternals::config': } ~>
  class { '::appinternals::service': } ->
  Class['::appinternals']
}

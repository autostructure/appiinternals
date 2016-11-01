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
  String $analysis_server,
  String $download_file_url,
) {
  class { '::appinternals::install': } ->
  class { '::appinternals::config': } ~>
  class { '::appinternals::service': } ->
  Class['::appinternals']
}

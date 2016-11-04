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
  String            $download_file_url,
  String            $user_account,
  String            $install_directory,
  String            $extract_directory,
  String            $analysis_server_host,
  Optional[Integer] $analysis_server_port = undef,
  Boolean           $is_analysis_server_secure = false,
  Boolean           $is_auto_instrument = true,
) {
  contain ::appinternals::pre_install
  contain ::appinternals::install
  contain ::appinternals::config
  contain ::appinternals::service

  class { '::appinternals::pre_install': } ->
  class { '::appinternals::install': } ->
  class { '::appinternals::config': } ~>
  class { '::appinternals::service': } ->
  Class['::appinternals']
}

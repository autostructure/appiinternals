# == Class appinternals::install
#
# This class is called from appinternals for install.
#
class appinternals::pre_install {
  # Download latest install and unpack to opnet home dir
  staging::deploy { 'appinternals_agent_latest_linux.gz':
    source => $::appinternals::download_file_url,
    target => $::appinternals::extract_directory,
  }
}

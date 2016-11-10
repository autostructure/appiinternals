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

  file {'/tmp/install.sh':
    ensure  => present,
    content => epp(
      'appinternals/install.properties.epp',
      {
        user_account              => $::appinternals::user_account,
        install_directory         => $::appinternals::install_directory,
        extract_directory         => $::appinternals::extract_directory,
        analysis_server_host      => $::appinternals::analysis_server_host,
        analysis_server_port      => $::appinternals::analysis_server_port,
        is_analysis_server_secure => $::appinternals::is_analysis_server_secure,
        is_auto_instrument        => $::appinternals::is_auto_instrument,
      },
    )
  }
}

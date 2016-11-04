# == Class appinternals::install
#
# This class is called from appinternals for install.
#
class appinternals::pre_install {
  user {'s_user':
    ensure => present,
  }

  # Download latest install and unpack to opnet home dir
  staging::deploy { 'appinternals_agent_latest_linux.gz':
    source => $::appinternals::download_file_url,
    target => '/tmp',
    notify => [
      File['/tmp/appinternals_agent_latest_linux']
    ],
  }
}

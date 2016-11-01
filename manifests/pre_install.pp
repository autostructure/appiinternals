# == Class appinternals::install
#
# This class is called from appinternals for install.
#
class appinternals::pre_install {
  #  gid      => 1000,

  accounts::user { 'S_RIVERBED':
    uid      => 1134213252,
    shell    => '/bin/bash',
    home     => '/home/S_RIVERBED',
    password => 'password',
    locked   => false,
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

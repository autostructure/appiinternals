# == Class appinternals::install
#
# This class is called from appinternals for install.
#
class appinternals::install {
  # Create opnet user
  user {'opnet':
    ensure => present,
    home   => '/home/opnet',
    before => Archive['/home/opnet/appinternals_agent_latest_linux.gz'],
  }

  # Grab file
  archive { '/home/opnet/appinternals_agent_latest_linux.gz':
    source       => 'http://download.appinternals.com/agents/a/appinternals_agent_latest_linux.gz',
    extract      => true,
    extract_path => '/home/opnet',
    #    notify       => File['/home/opnet/appinternals_agent_latest_linux'],
  }

  # Make sure script is executable
  #file {'/home/opnet/appinternals_agent_latest_linux':
  #  ensure => file,
  #  mode   => '0755',
  #}
}

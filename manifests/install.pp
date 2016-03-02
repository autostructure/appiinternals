# == Class appinternals::install
#
# This class is called from appinternals for install.
#
class appinternals::install {
  # Create opnet user
  user {'opnet':
    ensure => present,
    home   => '/home/opnet',
    before => ::Staging::Deploy['appinternals_agent_latest_linux.gz'],
  }

  staging::deploy { 'appinternals_agent_latest_linux.gz':
    source => 'http://download.appinternals.com/agents/a/appinternals_agent_latest_linux.gz',
    target => '/home/opnet',
    notify => File['/home/opnet/appinternals_agent_latest_linux'],
  }

  # Make sure script is executable
  file {'/home/opnet/appinternals_agent_latest_linux':
    mode => '0755',
  }

  $appinternals_install_stdin = @(EOT)
    <<END
    1
    /tmp
    opnet
    /opt/opnet
    y
    10.250.32.21
    y
    yes
    END
    | EOT

  exec {"/home/opnet/appinternals_agent_latest_linux ${$appinternals_install_stdin}":
    path => '/home/opnet',
  }
}

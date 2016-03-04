# == Class appinternals::install
#
# This class is called from appinternals for install.
#
class appinternals::install {
  # Appinsternals install script
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

  # Create opnet user
  user {'opnet':
    ensure => present,
    home   => '/home/opnet',
    before => File['/home/opnet'],
  }

  # Create opnet user home directory
  file {'/home/opnet':
    ensure => directory,
    #before => ::Staging::Deploy['appinternals_agent_latest_linux.gz'],
    before => Exec['curl http://download.appinternals.com/agents/a/appinternals_agent_latest_linux.gz | gunzip -c > appinternals_agent_latest_linux'],
    owner  => 'opnet',
  }

  ## Pull gz file which is not supported staging deploy format
  exec {"curl http://download.appinternals.com/agents/a/appinternals_agent_latest_linux.gz | gunzip -c > appinternals_agent_latest_linux":
    cwd         => '/home/opnet',
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
    creates     => '/home/opnet/appinternals_agent_latest_linux',
    unless      => 'ls /opt/opnet/Panorama/hedzup/mn/bin/dsatcl',
    logoutput   => 'true',
  }

  ## change mode 
  exec {"chmod 0754 /home/opnet/appinternals_agent_latest_linux":
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/home/opnet',
    unless      => 'ls /opt/opnet/Panorama/hedzup/mn/bin/dsatcl',
    logoutput   => 'true',
    before      => Exec["appinternals_agent_latest_linux ${appinternals_install_stdin}"],
  }

  ## execute
  exec {"appinternals_agent_latest_linux ${appinternals_install_stdin}":
    cwd         => '/home/opnet',
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:.',
    unless      => 'ls /opt/opnet/Panorama/hedzup/mn/bin/dsatcl',
    logoutput   => 'true',
    notify      => Exec['dsactl start'],
  }

#  # Download latest install and unpack to opnet home dir
#  staging::deploy { 'appinternals_agent_latest_linux':
#    #source => 'http://download.appinternals.com/agents/a/appinternals_agent_latest_linux.gz',
#    source => '/tmp/appinternals_agent_latest_linux',
#    target => '/home/opnet',
#    notify => [
#      File['/home/opnet/appinternals_agent_latest_linux'],
#      Exec["appinternals_agent_latest_linux ${appinternals_install_stdin}"]
#    ],
#  }

#  # Make sure script is executable
#  file {'/home/opnet/appinternals_agent_latest_linux':
#    mode   => '0755',
#    before => Exec["appinternals_agent_latest_linux ${appinternals_install_stdin}"],
#  }

#  # Run the script onetime after unpack
#  exec {"appinternals_agent_latest_linux ${appinternals_install_stdin}":
#    path        => '/home/opnet',
#    refreshonly => true,
#    notify      => Exec['dsactl start'],
#  }

  # Run the script onetime after unpack
  exec {'dsactl start':
    cwd         => '/home/opnet',
    path        => [
      '/opt/opnet/Panorama/hedzup/mn/bin',
      '/usr/local/sbin',
      '/sbin',
      '/bin',
      '/usr/sbin',
      '/usr/bin',
      '/root/bin',
      '/usr/local/bin',
      '/opt/puppetlabs/bin',
    ],
    user        => 'opnet',
    refreshonly => true,
  }
}

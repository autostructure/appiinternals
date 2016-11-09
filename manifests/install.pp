# == Class appinternals::install
#
# This class is called from appinternals for install.
#
class appinternals::install {
  # Make sure script is executable
  file {'/tmp/appinternals_agent_latest_linux':
    mode   => '0755',
    notify =>
      Exec['appinternals_agent_latest_linux install.sh'],
  }

  # Run the script onetime after unpack
  exec {'appinternals_agent_latest_linux install.sh':
    path        => '/tmp',
    refreshonly => true,
    notify      => Exec['dsactl start'],
  }

  # Run the script onetime after unpack
  exec {'dsactl start':
    cwd         => '/opt/riverbed/Panorama/hedzup/mn/bin',
    path        => [
      '/opt/riverbed/Panorama/hedzup/mn/bin',
      '/usr/local/sbin',
      '/sbin',
      '/bin',
      '/usr/sbin',
      '/usr/bin',
      '/root/bin',
      '/usr/local/bin',
      '/opt/puppetlabs/bin',
    ],
    user        => 'S_RIVERBED',
    refreshonly => true,
  }
}

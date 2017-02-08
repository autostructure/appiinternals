# == Class appinternals::install
#
# This class is called from appinternals for install.
#
class appinternals::install {
  # Make sure script is executable
  file {'/tmp/appinternals_agent_latest_linux':
    mode   => '0755',
    notify =>
      Exec['/tmp/appinternals_agent_latest_linux -silent /tmp/install.properties'],
  }

  # Run the script onetime after unpack
  exec {'/tmp/appinternals_agent_latest_linux -silent /tmp/install.properties':
    cwd     => '/tmp',
    notify  => Exec['dsactl start'],
    creates => $::appinternals::install_directory,
  }

  # Run the script onetime after unpack
  exec {'dsactl start':
    cwd         => "${::appinternals::install_directory}/Panorama/hedzup/mn/bin",
    path        => [
      "${::appinternals::install_directory}/Panorama/hedzup/mn/bin",
      '/usr/local/sbin',
      '/sbin',
      '/bin',
      '/usr/sbin',
      '/usr/bin',
      '/root/bin',
      '/usr/local/bin',
      '/opt/puppetlabs/bin',
    ],
    user        => $::appinternals::user_account,
    refreshonly => true,
  }
}

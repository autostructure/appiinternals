# == Class appinternals::install
#
# This class is called from appinternals for install.
#
class appinternals::install {
  # Appinsternals install script
  $appinternals_install_stdin = @('EOT')
    <<END
    1
    /tmp
    S_RIVERBED
    /opt/riverbed
    y
    $::appinternals::analysis_server
    y
    yes
    END
    | EOT

  # Make sure script is executable
  file {'/tmp/appinternals_agent_latest_linux':
    mode   => '0755',
    before =>
      Exec["appinternals_agent_latest_linux ${appinternals_install_stdin}"],
  }

  # Run the script onetime after unpack
  exec {"appinternals_agent_latest_linux ${appinternals_install_stdin}":
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

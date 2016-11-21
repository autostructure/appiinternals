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
    cwd         => '/tmp',
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

  def withRvm(version, cl) {
      withRvm(version, "executor-${env}.EXECUTOR_NUMBER") {
          cl()
      }
  }

  def withRvm(version, gemset, cl) {
      RVM_HOME='$HOME/.rvm'
      paths = [
          "${RVM_HOME}/gems/${version}@${gemset}/bin",
          "${RVM_HOME}/gems/${version}@global/bin",
          "${RVM_HOME}/rubies/${version}/bin",
          "${RVM_HOME}/bin",
          "${env}.PATH"
      ]

      def path = paths.join(':')

      # withEnv(["PATH=${env.PATH}:$RVM_HOME", "RVM_HOME=$RVM_HOME"]) {
      withEnv(["PATH=${path}:${RVM_HOME}", "RVM_HOME=${RVM_HOME}"]) {
          sh "set +x; source ${RVM_HOME}/scripts/rvm; rvm use --create --install --binary ${version}@${gemset}"
      }

      withEnv([
          "PATH=${path}",
          "GEM_HOME=${RVM_HOME}/gems/${version}@${gemset}",
          "GEM_PATH=${RVM_HOME}/gems/${version}@${gemset}:${RVM_HOME}/gems/${version}@global",
          "MY_RUBY_HOME=${RVM_HOME}/rubies/${version}",
          "IRBRC=${RVM_HOME}/rubies/${version}/.irbrc",
          "RUBY_VERSION=${version}"
          ]) {
              # 'gem install bundler'
              cl()
          }
      }
}

class { 'appinternals':
  download_file_url         => 'http://artifactory.azcender.com/artifactory/application-release-local/com/appinternals/appinternals_agent_linux/appinternals_agent_linux-v10.4.0.582.gz',
  user_account              => 's_user',
  install_directory         => '/opt/account',
  extract_directory         => '/tmp',
  analysis_server_host      => '10.0.0.0',
  is_analysis_server_secure => false,
  is_auto_instrument        => true,
  c00l = beans,
}

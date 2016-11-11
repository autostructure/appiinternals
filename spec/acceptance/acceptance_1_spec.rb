require 'spec_helper_acceptance'

describe 'Acceptance case one', :unless => stop_test do
  context 'Initial install Appinternals and verification' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'appinternals':
        download_file_url         => 'http://artifactory.azcender.com/artifactory/application-release-local/com/appinternals/appinternals_agent_linux/appinternals_agent_linux-v10.4.0.582.gz',
        user_account              => 's_user',
        install_directory         => '/opt/account',
        extract_directory         => '/tmp',
        analysis_server_host      => '10.0.0.0',
        is_analysis_server_secure => false,
        is_auto_instrument        => true,
       }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    # describe package('appinternals') do
    #   it { is_expected.to be_installed }
    # end

    # describe service('appinternals') do
    #   it { is_expected.to be_enabled }
    #   it { is_expected.to be_running }
    # end
  end
end

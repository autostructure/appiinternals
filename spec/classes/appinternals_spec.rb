require 'spec_helper'

describe 'appinternals', :type => :class do
  let(:params) do
    {
      download_file_url: 'http://artifactory.azcender.com/artifactory/application-release-local/com/appinternals/appinternals_agent_linux/appinternals_agent_linux-v10.4.0.582.gz',
      user_account: 's_user',
      install_directory: '/opt/account',
      extract_directory: '/tmp',
      analysis_server_host: '10.0.0.0',
      is_analysis_server_secure: false,
      is_auto_instrument: true
    }
  end

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        facts[:staging_http_get] = 'curl'

        let(:facts) do
          facts
        end

        context "appinternals class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('appinternals::install').that_comes_before('Class[appinternals::config]') }
          it { is_expected.to contain_class('appinternals::config') }
          it { is_expected.to contain_class('appinternals::service').that_subscribes_to('Class[appinternals::config]') }

          # it { is_expected.to contain_service('appinternals') }
          # it { is_expected.to contain_package('appinternals').with_ensure('present') }
        end
      end
    end
  end

  # context 'unsupported operating system' do
  #   describe 'appinternals class without any parameters on Solaris/Nexenta' do
  #     let(:facts) do
  #       {
  #         :osfamily        => 'Solaris',
  #         :operatingsystem => 'Nexenta'
  #       }
  #     end

  #     it { expect { is_expected.to contain_package('appinternals') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
  #   end
  # end
end

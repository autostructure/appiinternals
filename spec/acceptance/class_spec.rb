require 'spec_helper'

describe 'appinternals class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'appinternals': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('appinternals') do
      it { is_expected.to be_installed }
    end

    describe service('appinternals') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end

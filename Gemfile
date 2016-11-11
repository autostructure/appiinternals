source "https://rubygems.org"

# group :test do
#   gem 'rake'
#   gem 'puppet' # , ENV['PUPPET_GEM_VERSION'] || '~> 3.8.0'
#   # gem 'hiera-puppet', '1.0.0'
#   # gem 'hiera'
#   gem 'rspec' # , '< 3.2.0'
#   gem 'rspec-puppet' #, :git => 'https://github.com/rodjek/rspec-puppet.git'
#   gem 'puppetlabs_spec_helper'
#   gem 'metadata-json-lint'
#   gem 'rspec-puppet-facts'
#   gem 'rubocop' # , '0.33.0'
#   gem 'simplecov' # , '>= 0.11.0'
#   gem 'simplecov-console'
#   gem 'syck'

#   gem 'puppet-lint-absolute_classname-check'
#   gem 'puppet-lint-leading_zero-check'
#   gem 'puppet-lint-trailing_comma-check'
#   gem 'puppet-lint-version_comparison-check'
#   gem 'puppet-lint-classes_and_types_beginning_with_digits-check'
#   gem 'puppet-lint-unquoted_string-check'
# end

# group :development do
#   gem "travis"
#   gem "travis-lint"
#   gem "puppet-blacksmith"
#   gem "guard-rake"
# end



# group :system_tests do
#   gem "beaker"
#   gem "beaker-rspec"
#   gem "beaker-puppet_install_helper"
# end

source ENV['GEM_SOURCE'] || "https://rubygems.org"

def location_from_env(env, default_location = [])
  if location = ENV[env]
    if location =~ /^((?:git|https?)[:@][^#]*)#(.*)/
      [{ :git => $1, :branch => $2, :require => false }]
    elsif location =~ /^file:\/\/(.*)/
      ['>= 0', { :path => File.expand_path($1), :require => false }]
    else
      [location, { :require => false }]
    end
  else
    default_location
  end
end

group :development, :unit_tests do
  gem 'metadata-json-lint'
  gem 'puppet_facts'
  gem 'puppet-blacksmith', '>= 3.4.0'
  gem 'puppetlabs_spec_helper', '>= 1.2.1'
  gem 'rspec-puppet', '>= 2.3.2'
  gem 'rspec-puppet-facts'
  gem 'mocha', '< 1.2.0'
  gem 'simplecov'
  gem 'parallel_tests', '< 2.10.0' if RUBY_VERSION < '2.0.0'
  gem 'parallel_tests' if RUBY_VERSION >= '2.0.0'
  gem 'rubocop', '0.41.2' if RUBY_VERSION < '2.0.0'
  gem 'rubocop' if RUBY_VERSION >= '2.0.0'
  gem 'rubocop-rspec', '~> 1.6' if RUBY_VERSION >= '2.3.0'
  gem 'json_pure', '<= 2.0.1' if RUBY_VERSION < '2.0.0'
end
group :system_tests do
  gem 'beaker', *location_from_env('BEAKER_VERSION', []) if RUBY_VERSION >= '2.3.0'
  gem 'beaker', *location_from_env('BEAKER_VERSION', ['< 3']) if RUBY_VERSION < '2.3.0'
  gem 'beaker-pe' if RUBY_VERSION >= '2.3.0'
  gem 'beaker-rspec', *location_from_env('BEAKER_RSPEC_VERSION', ['>= 3.4'])
  gem 'serverspec'
  gem 'beaker-puppet_install_helper'
  gem 'master_manipulator'
  gem 'beaker-hostgenerator', *location_from_env('BEAKER_HOSTGENERATOR_VERSION', [])
end

# gem 'facter', *location_from_env('FACTER_GEM_VERSION')
# gem 'puppet', *location_from_env('PUPPET_GEM_VERSION')
gem 'puppet'

if File.exists? "#{__FILE__}.local"
  eval(File.read("#{__FILE__}.local"), binding)
end

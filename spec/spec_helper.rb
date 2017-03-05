require 'simplecov'
require 'coveralls'
require 'pry'
require 'exit_code_matchers'

Coveralls.wear!

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require_relative '../config/bootstrap.rb'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
spec_dir = File.join($app_root, 'spec')
$LOAD_PATH.unshift(spec_dir) unless $LOAD_PATH.include?(spec_dir)

require 'hscode'
require 'rspec'

RSpec.configure do |config|
  # custom RSpec configurations
end

ENV['RUBY_ENV'] = 'test'

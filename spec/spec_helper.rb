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
  config.before(:all) do
    @original_stdout = $stdout
    $stdout = File.new(File.join(File.dirname(__FILE__), 'test.log'), 'w')
    Pry.output = @original_stdout
  end

  config.after(:all) do
    $stdout = @original_stdout
    @original_stdout = nil
  end
end

ENV['RUBY_ENV'] = 'test'

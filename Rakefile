require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require_relative 'config/bootstrap'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

namespace :setup do
  desc "source environment variables"
  task :env do
    Bootstrap::Config.get
  end
end

task :default => [:spec, :rubocop]

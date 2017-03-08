#!/usr/bin/env ruby
# encoding: UTF-8

APP_ROOT = File.expand_path('../../', __FILE__)

require 'yaml'
require 'erb'

module Bootstrap
  module Config
    def self.get
      YAML.load(
        ERB.new(File.read("#{APP_ROOT}/config/env.yaml")).result
      ).each { |key, value| ENV[key] = value }
    end
  end
end

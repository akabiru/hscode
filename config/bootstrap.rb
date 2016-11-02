#!/usr/bin/env ruby
# encoding: UTF-8

$app_root = File.expand_path('../../', __FILE__)

require 'yaml'
require 'erb'

module Bootstrap
  module Config
    def self.get
      YAML.load(
        ERB.new(File.read("#{$app_root}/config/env.yaml")).result
      ).each { |key, value| ENV[key] = value }
    end
  end
end

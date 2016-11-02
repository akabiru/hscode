require 'hscode/version'
require 'hscode/input_parser'
require 'optparse'
require 'ostruct'
require 'pp'

module Hscode
  class CliController
    def call(args)
      options = Hscode::InputParser.parse(args)
      pp options
      pp args
    end
  end
end

require 'hscode/version'
require 'hscode/input_parser'
require 'hscode/http_status_codes'
require 'optparse'
require 'ostruct'

module Hscode
  class CliController
    def self.call(args)
      options = Hscode::InputParser.new.parse(args)
      puts options
    end
  end
end

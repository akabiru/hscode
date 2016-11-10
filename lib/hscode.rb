require 'hscode/version'
require 'hscode/input_parser'
require 'hscode/http_status_codes'
require 'optparse'
require 'ostruct'

module Hscode
  class CliController
    def self.call(args)
      options = Hscode::InputParser.new.parse(args)
      print_code(options)
    end

    private

    def self.print_code(options)
      if options.verbose
      else
      end
    end
  end
end

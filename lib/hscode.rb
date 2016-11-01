require "hscode/version"
require "optparse"
require "ostruct"

module Hscode
  class InputParser
    #
    # Return a structure describing options
    #
    def self.parse(args)
      # Default options
      options = OpenStruct.new
      options.verbose = false

      opt_parser = OptionParser.new do |parser|
        parser.banner = "Usage: hscode [options]"

        parser.separator ""
        parser.separator "Specific options:"

        parser.on("-s", "--status [CODE]", Integer,
          "Show HTTP status code documentation") do |code|
            puts code
            exit
        end

        parser.separator ""
        parser.separator "Common options:"

        parser.on_tail("-h", "--help", "Show this help message") do
          puts parser
          exit
        end

        parser.on_tail("--version", "Show version") do
          puts ::VERSION
          exit
        end
      end

      opt_parser.parse!(args)
      options
    end # parser()
  end # class OptionsParser
end

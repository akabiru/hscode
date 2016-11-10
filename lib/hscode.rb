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
      status_code = HTTP_STATUS_CODES[options.status_code.to_i]

      if status_code
        PrettyPrint.print(
          "#{options.status_code} - #{status_code[:title]}",
          options.status_code.to_s[0]
        )
      else
        PrettyPrint.print(
          "#{options.status_code} is not a valid code. See 'hscode --help'.",
          "5"
        )
      end
    end
  end
end

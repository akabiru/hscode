require 'hscode/version'
require 'hscode/input_parser'
require 'hscode/http_status_codes'
require 'optparse'
require 'ostruct'

module Hscode
  class CliController
    def call(args)
      options = Hscode::InputParser.parse(args)
      print_response(options)
    end

    private

    def print_response(options)
      if HTTP_STATUS_CODES[options.status_code]
        puts "Status Code: #{options.status_code}\n\n",
             HTTP_STATUS_CODES[options.status_code][:title]
        if options.verbose
          puts ''
          HTTP_STATUS_CODES[options.status_code][:description].each do |desc|
            puts desc, ''
          end
        end
      else
        puts "hscode -c #{options.status_code} is not a valid option."\
        " See 'hscode --list'."
      end
    end
  end
end

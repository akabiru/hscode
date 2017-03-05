require 'hscode/version'
require 'hscode/input_parser'
require 'hscode/http_status_codes'
require 'hscode/pretty_print'
require 'optparse'
require 'ostruct'

module Hscode
  class CliController
    def self.call(args)
      options = Hscode::InputParser.new.parse(args)
      options.title ? print_title_code(options) : print_code(options)
    end

    private_class_method

    def self.print_code(options)
      status_code =  HTTP_STATUS_CODES[options.status_code.to_i]

      unless status_code
        puts "#{options.status_code} is not a valid code. See 'hscode --help'."
        exit
      end

      PrettyPrint.print(
        "#{options.status_code} - #{status_code[:title]}",
        options.status_code.to_s[0]
      )
      print_description(status_code) if options.verbose
    end

    def self.print_title_code(options)
      status_object =  HTTP_STATUS_CODES.detect {|_, value| value[:title].downcase == options.title.downcase}

      unless status_object
        puts "#{options.title} is not a valid HTTP status. See 'hscode --list' to see the list of valid HTTP codes."
        exit
      end

      status_code = status_object.first

       PrettyPrint.print(
        "#{status_object[1][:title]} - #{status_code}",
        status_code.to_s[0]
      )

      print_description(status_object[1]) if options.verbose
    end

    def self.print_description(status_code)
      status_code[:description].each do |desc|
        PrettyPrint.print("\n#{desc}", '0')
      end
    end
  end
end

require 'hscode/version'
require 'hscode/input_parser'
require 'hscode/http_status_codes'
require 'hscode/pretty_print'
require 'hscode/status_code_types'
require 'optparse'
require 'ostruct'

module Hscode
  class CliController
    def self.call(args)
      options = Hscode::InputParser.new.parse(args)
      options.title ? print_title(options) : print_code(options)
    end

    private_class_method

    def self.print_code(options)
      status_code = HTTP_STATUS_CODES[options.status_code.to_i]
      unless status_code
        puts "#{options.status_code} is not a valid code. See 'hscode --help'."
        exit 1
      end

      print_result(options.status_code, status_code[:title],
                   status_code[:description], options.verbose)
      exit
    end

    def self.print_title(options)
      title_data = get_title_data(options.title)

      validate_title_data(title_data, options)

      title_data.each do |data|
        print_result(data.first, data[1][:title],
                     data[1][:description], options.verbose)
      end
      exit
    end

    def self.validate_title_data(title_data, options)
      return unless title_data.empty?
      puts "#{options.title} is not a valid HTTP status. " \
      "See 'hscode --list' to see the list of valid HTTP codes."
      exit 1
    end

    def self.get_title_data(title)
      data = HTTP_STATUS_CODES.select do |_, value|
        value[:title].downcase.match title.downcase
      end
      data
    end

    def self.print_result(code, title, desc, verbose)
      PrettyPrint.print("#{code} - #{title}", code.to_s[0])
      print_description(desc) if verbose
    end

    def self.print_description(descriptions)
      descriptions.each do |desc|
        PrettyPrint.print("\n#{desc}", '0')
      end
    end
  end
end

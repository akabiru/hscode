require 'hscode/pretty_print'

module Hscode
  class InputParser
    attr_reader :options
    CODE_REF = {
      '1xx' => 'Informational',
      '2xx' => 'Sucess',
      '3xx' => 'Redirection',
      '4xx' => 'Client Error',
      '5xx' => 'Server Error'
    }

    def initialize
      @options = OpenStruct.new
    end

    def parse(args)
      option_parser.parse!(args)
      options
    rescue OptionParser::InvalidOption,
           OptionParser::InvalidArgument,
           OptionParser::MissingArgument => e
      puts e, "See 'hscode --help'."
      exit 1
    end

    private

    def option_parser
      OptionParser.new do |opts|
        opts.banner = 'Usage: hscode [options]'
        opts.separator ''
        opts.separator 'Specific options:'

        run_verbosely(opts)
        show_status_code(opts)
        list_status_codes(opts)
        list_status_codes_by_type(opts)

        opts.separator ''

        display_help_message(opts)
        display_version_number(opts)
      end
    end

    def show_status_code(opts)
      opts.on('-c', '--code CODE', Integer,
              'Show HTTP status code documentation') do |code|
        options.status_code = code
      end
    end

    def run_verbosely(opts)
      opts.on('-v', '--verbose',
              'Show full HTTP status code documentation') do |v|
        options.verbose = v
      end
    end

    def list_status_codes(opts)
      opts.on('-l', '--list', 'List all HTTP status codes') do
        print_all_codes
      end
    end

    def list_status_codes_by_type(opts)
      opts.on('-l TYPE', '--list TYPE',
              'List all HTTP status codes of that type') do |type|
        options.status_type = type
        print_all_codes_by_type(type)
      end
    end

    def display_help_message(opts)
      opts.on_tail('-h', '--help', 'Show this help message') do
        puts opts, 'Examples:
          hscode -c 200
          hscode -c 200 -v
          hscode -l
        '
        exit
      end
    end

    def display_version_number(opts)
      opts.on_tail('--version', 'Show version') do
        puts Hscode::VERSION
        exit
      end
    end

    def print_all_codes_by_type(type)
      HTTP_STATUS_CODES.map do |code, info_hash|
        next unless type.to_s[0] == code.to_s[0]
        colour_code = code.to_s[0]
        PrettyPrint.print("#{code} - #{info_hash[:title]}", colour_code)
      end
      exit
    end

    def print_all_codes
      HTTP_STATUS_CODES.map do |code, info_hash|
        colour_code = code.to_s[0]
        PrettyPrint.print("#{code} - #{info_hash[:title]}", colour_code)
      end
      exit
    end
  end
end

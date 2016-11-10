require 'hscode/pretty_print'

module Hscode
  class InputParser
    attr_reader :options

    def initialize
      @options = OpenStruct.new
    end

    def parse(args)
      option_parser.parse!(args)
      @options
    rescue OptionParser::InvalidOption => e
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

        opts.separator ''

        display_help_message(opts)
        display_version_number(opts)
      end
    end

    def run_verbosely(opts)
      opts.on('-v', '--verbose',
              'Show full HTTP status code documentation') do |v|
        options.verbose = v
      end
    end

    def show_status_code(opts)
      opts.on('-c', '--code CODE', Integer,
              'Show HTTP status code documentation') do |code|
        options.status_code = code
      end
    end

    def list_status_codes(opts)
      opts.on('-l', '--list', 'List all HTTP status codes') do
        print_all_codes
      end
    end

    def display_help_message(opts)
      opts.on_tail('-h', '--help', 'Show this help message') do
        puts opts
        exit
      end
    end

    def display_version_number(opts)
      opts.on_tail('--version', 'Show version') do
        puts Hscode::VERSION
        exit
      end
    end

    def print_all_codes
      HTTP_STATUS_CODES.map do |code, description|
        colour_code = code.to_s[0]
        PrettyPrint.print("#{code} - #{description[:title]}", colour_code)
      end
      exit
    end
  end
end

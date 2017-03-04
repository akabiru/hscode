require 'hscode/pretty_print'

module Hscode
  class InputParser
    attr_reader :options

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
      opts.on('-l', '--list [TYPE]',
              'List all HTTP status codes of type') do |type|
        print_all_codes unless type
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
          hscode -l 2xx
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
      raise OptionParser::InvalidOption unless type =~ /\A[1-5]x{2}\z/

      colour_code = type.to_s[0]
      PrettyPrint.print("#{type}   #{STATUS_CODE_TYPES[type]}\n", colour_code)

      http_group(type).map do |code, info_hash|
        PrettyPrint.print("#{code} - #{info_hash[:title]}", colour_code)
      end
      exit
    end

    def http_group(type)
      HTTP_STATUS_CODES.select do |code, _|
        type.start_with? code.to_s[0]
      end
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

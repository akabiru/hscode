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
        parser.banner = 'Usage: hscode [options]'

        parser.separator ''
        parser.separator 'Specific options:'

        parser.on('-c', '--code [CODE]', Integer,
                  'Show HTTP status code documentation') do |code|
          options.status_code = code
        end

        parser.on('-v', '--verbose',
                  'Show full HTTP status code documentation') do |_v|
          options.verbose = true
        end

        parser.on('-l', '--list', 'List all HTTP status codes') do
          HTTP_STATUS_CODES.each do |code, info|
            puts "#{code}  - #{info[:title]}"
          end
          exit
        end

        parser.separator ''

        parser.on_tail('-h', '--help', 'Show this help message') do
          puts parser
          exit
        end

        parser.on_tail('--version', 'Show version') do
          puts Hscode::VERSION
          exit
        end
      end

      opt_parser.parse!(args)
      options
    rescue OptionParser::InvalidOption => e
      puts e, "See 'hscode --help'."
      exit 1
    end # parser()
  end # class OptionsParser
end

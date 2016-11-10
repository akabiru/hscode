module Hscode
  class PrettyPrint
    COLORS = {
      '1' => 6,
      '2' => 2,
      '3' => 3,
      '4' => 9,
      '5' => 1
    }.freeze

    def self.print(text, colour_code)
      puts make_pretty(text, COLORS[colour_code])
    end

    private_class_method

    def self.make_pretty(text, color_code)
      "\x1b[38;5;#{color_code}m#{text}\n"
    end
  end
end

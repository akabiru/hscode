#!/usr/bin/env ruby
# encoding: UTF-8

module Hscode
  COLORS = {
    info: 6,
    success: 2,
    neutral: 3,
    error: 1,
    warning: 9
  }

  class PrettyPrint
    def self.make_pretty(text, color_code)
      "\x1b[38;5;#{color_code}m#{text}\n"
    end
  end
end

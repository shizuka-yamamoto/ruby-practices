#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  l_option = ARGV.getopts('l')
  if ARGV[0]
    argument_input(l_option)
  else
    standard_input(l_option)
  end
end

def argument_input(l_option)
  total_count_lines = total_count_words = total_count_bytes = 0

  ARGV.each do |file_name|
    text = File.read(file_name)
    total_count_lines += text.count("\n")
    total_count_words += text.split(/\s+/).length
    total_count_bytes += text.bytesize
    calc_of_line_word_byte(l_option, text)
    puts " #{file_name}"
  end

  if ARGV.size > 1 # ファイルが複数ある場合は合計を出力
    print total_count_lines.to_s.rjust(8)
    unless l_option['l']
      print total_count_words.to_s.rjust(8)
      print total_count_bytes.to_s.rjust(8)
    end
    puts ' total'
  end
end

def standard_input(l_option)
  text = $stdin.read
  calc_of_line_word_byte(l_option, text)
  puts "\n"
end

def calc_of_line_word_byte(l_option, text)
  print text.count("\n").to_s.rjust(8)
  unless l_option['l']
    print text.split(/\s+/).length.to_s.rjust(8)
    print text.bytesize.to_s.rjust(8)
  end
end

main

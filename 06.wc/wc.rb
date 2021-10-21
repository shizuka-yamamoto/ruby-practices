#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  l_option = ARGV.getopts('l')
  inputs = parse_input
  numbers = calc(inputs)
  format(numbers, l_option)
end

def parse_input
  if ARGV.size >= 1 # ファイル指定あり
    ARGV.map do |file_name|
      {
        file_name: file_name,
        text: File.read(file_name)
      }
    end
  else
    [
      {
        file_name: '',
        text: $stdin.read
      }
    ]
  end
end

def calc(inputs)
  inputs.map do |content|
    line = content[:text].count("\n")
    word = content[:text].split(/\s+/).length
    byte = content[:text].bytesize
    file_name = content[:file_name]
    [line, word, byte, file_name]
  end
end

def format(numbers, l_option)
  numbers.each do |number|
    print number[0].to_s.rjust(8)
    unless l_option['l']
      print number[1].to_s.rjust(8)
      print number[2].to_s.rjust(8)
    end
    puts " #{number[3]}"
  end

  return unless ARGV.size >= 2 # ファイルが複数ある場合は合計を出力

  number = numbers.transpose
  print number[0].sum.to_s.rjust(8)
  unless l_option['l']
    print number[1].sum.to_s.rjust(8)
    print number[2].sum.to_s.rjust(8)
  end
  puts ' total'
end

main

#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  l_option = ARGV.getopts('l')
  parse_input
  format(l_option)
end

def parse_input
  if ARGV.size >= 1 # ファイル指定あり
    text = ARGV.map do |file_name|
        {
          file_name: file_name,
          text: File.read(file_name)
        }
    end
  else
    text = [
            {
              file_name: "",
              text: $stdin.read
            },
            ]
  end
end

def calc
  if ARGV.size >= 1 # ファイル指定あり
    total_count_lines = total_count_words = total_count_bytes = 0
    @count_number = @files.map do |file_name|
      text = File.read(file_name)
      total_count_lines += text.count("\n")
      total_count_words += text.split(/\s+/).length
      total_count_bytes += text.bytesize
      line = text.count("\n")
      word = text.split(/\s+/).length
      byte = text.bytesize
      [line, word, byte, file_name]
    end
    @total_count_lines = total_count_lines
    @total_count_words = total_count_words
    @total_count_bytes = total_count_bytes
  else # 標準入力時
    line = @text.count("\n")
    word = @text.split(/\s+/).length
    byte = @text.bytesize
    @count_number = [[line, word, byte]]
  end
end

def format(l_option)
  @count_number.each do |content|
    print content[0].to_s.rjust(8)
    unless l_option['l']
      print content[1].to_s.rjust(8)
      print content[2].to_s.rjust(8)
    end
    puts " #{content[3]}"
  end

  return unless ARGV.size > 1 # ファイルが複数ある場合は合計を出力

  print @total_count_lines.to_s.rjust(8)
  unless l_option['l']
    print @total_count_words.to_s.rjust(8)
    print @total_count_bytes.to_s.rjust(8)
  end
  puts ' total'
end

main

#!/usr/bin/env ruby

require 'optparse'
require 'etc'

options = ARGV.getopts('a', 'l', 'r')
files = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob("*")
files = files.reverse if options['r']

# 基準なる行数
line_count = if (files.size % 3 == 0)
               files.size / 3
             else
               files.size / 3 + 1
             end

# transposeを使うために一時的な配列の作成
temporary_array = files.each_slice(line_count).to_a
temporary_array.each do |line|
  if line.size < line_count
    (line_count - line.size).times do
      line << ' '
    end
  end
end

filename_length = files.map {|file| file.length }
max_filename_length = filename_length.max

unless options['l']
  temporary_array.transpose.each do |array|
    array.each do |file|
      print file.ljust(max_filename_length + 2)
    end
    print "\n"
  end
end

if options['l']
  def file_type(type)
    {
      '10' => '-',
      '04' => 'd',
      '12' => 'l'
    }[type]
  end

  def file_mode(number_mode)
    to_symbol_mode = {
      '0' => '---',
      '1' => '--x',
      '2' => 'r--',
      '3' => '-w-',
      '4' => '-wx',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }
    number_mode.map do |number|
      to_symbol_mode[number]
    end
  end

  file_blocks = files.map {|file| File.lstat(file).blocks} 
  puts "total #{total = file_blocks.sum}"

  files.each do |file|
    fs = File.lstat(file)
    file_permission = fs.mode.to_s(8).rjust(6, '0')
    file_type = file_type(file_permission[0, 2])
    file_mode = file_mode(file_permission[3, 3].chars).join
    number_of_links = fs.nlink
    owner_name = Etc.getpwuid(fs.uid).name
    group_name = Etc.getgrgid(fs.gid).name
    file_size = fs.size
    time_stamp = fs.mtime.strftime("%m %d %H:%M")
    file_name = file
    puts "#{file_type}#{file_mode} #{number_of_links.to_s.rjust(3)} #{owner_name} #{group_name} #{file_size.to_s.rjust(4)} #{time_stamp} #{file_name}"
  end
end

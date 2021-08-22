#!/usr/bin/env ruby

require "date"
require 'optparse'

opt = ARGV.getopts("y:m:")
today = Date.today

year = if opt["y"]
        opt["y"].to_i
       else
        today.year
       end

month = if opt["m"]
          opt["m"].to_i
        else
          today.month
        end

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
week_day = ["日", "月", "火", "水", "木", "金", "土"]

puts "#{month}月 #{year}".center(20)
puts week_day.join(" ")
(first_day..last_day).each do |x|
  blank = "   "
  print blank *= x.wday if x.day == 1
  print "#{x.day.to_s} ".rjust(3)
  puts "\n" if x.saturday?
end


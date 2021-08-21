#!/usr/bin/env ruby

require "date"
require 'optparse'

opt = ARGV.getopts("y:m:")
today = Date.today

# オプションの指定があれば、該当の年月を、なければ当日を代入する
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

# いつのカレンダーか表示する
puts "#{month}月 #{year}".center(20)
# 曜日を表示する
puts week_day.join(" ")
# カレンダーを表示する
(first_day..last_day).each do |x|
  # 初日の曜日に合わせてスペースを入れる
  blank = "   "
  print blank *= x.wday if x.day == 1
  print "#{x.day.to_s} ".rjust(3) # 日にちを右寄せして表示する
  puts "\n" if x.saturday?  # 土曜日の後に改行を入れる
end


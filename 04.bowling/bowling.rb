#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

point = 0
frames.each_with_index do |frame, i|
  point += frame.sum
  next unless i < 9 && (frame[0] + frame[1] == 10) # 加点

  point += frames[i + 1][0]
  next unless frame[0] == 10

  point += if frames[i + 1][0] == 10
             frames[i + 2][0]
           else
             frames[i + 1][1]
           end
end
puts point

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

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each_with_index do |frame, i|
  point += frame.sum
  
  if i < 9 # 加算
    point += frames[i + 1][0] if frame[0] + frame[1] == 10 && frame[0] != 10 # スペア
    if frame[0] == 10 # ストライク
      point += frames[i + 1][0]
      if frames[i + 1][0] == 10
        point += frames[i + 2][0]
      else
        point += frames[i + 1][1]
      end
    end
  end
end
puts point

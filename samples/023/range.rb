case Time.now.hour
when 0...6
  puts 'まだ寝ています'
when 6...12
  puts '朝は眠い'
when 12...18
  puts '昼寝の時間です'
when 18...24
  puts 'そろそろ寝る時間です'
end

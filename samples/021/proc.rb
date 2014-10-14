pc0 = Proc.new do
  puts 'in proc'
end
pc0.call # => in proc

pc1 = Proc.new do |n|
  puts n * n
end
pc1.call(3) #=> 9

proc { puts 'hey' }

f = Fiber.new do
  Fiber.yield 'return by yield' # 処理を親に戻す
  Fiber.yield 'return by yield again'
  'end of block'
end

puts '--- 1 ---'
f.resume #=> 'return by yield'
puts '--- 2 ---'
f.resume #=> 'return by yield again'
puts '--- 3 ---'
f.resume #=> 'end of block'
puts '--- 4 ---'
f.resume #=> FiberError: dead fiber called

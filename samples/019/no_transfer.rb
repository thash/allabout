# transferを使わない
f1 = Fiber.new { 'one' }
f2 = Fiber.new { f1.resume; 'two' }

puts f2.resume #=> two

# f1もf2も既に死んでいる
puts f1.resume #=> dead fiber called (FiberError)
puts f2.resume #=> dead fiber called (FiberError)

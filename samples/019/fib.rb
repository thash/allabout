fibonacci = Fiber.new do
  x, y = 0, 1
  loop do
    Fiber.yield y # yieldに渡した値がresumeの返り値となる
    x, y = y, x + y
  end
end

puts fibonacci.resume #=> 1
puts fibonacci.resume #=> 1
puts fibonacci.resume #=> 2
puts fibonacci.resume #=> 3
puts fibonacci.resume #=> 5
puts fibonacci.resume #=> 8
puts fibonacci.resume #=> 13

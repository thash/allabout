# transferを使う
require 'fiber'

f1 = Fiber.new { 'one' }
f2 = Fiber.new { f1.transfer; 'two' }

puts f2.resume #=> one

# 一度transferしたfiberはresumeできない
puts f1.resume #=> cannot resume transferred Fiber (FiberError)
puts f2.resume #=> double resume (FiberError)

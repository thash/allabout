Fiber.new
# => ArgumentError: tried to create Proc object without a block

f = Fiber.new { puts 'fiber!' }
#=> #<Fiber:0x007f9175d7d210>

Fiber.ancestors
# => [Fiber, Object, Kernel, BasicObject]

Fiber.instance_methods(false)
#=> [:resume]

f.resume
# => fiber!

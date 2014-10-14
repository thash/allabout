l0 = lambda do |n|
  n * n
end
p l0.call(10) #=> 100

l1 = -> (n) { n * n }
p l1.call(20) # => 400

p Proc.new {}.lambda? #=> false
p proc {}.lambda?     #=> false
p lambda {}.lambda?   #=> true

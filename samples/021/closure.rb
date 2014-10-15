x = 2

1.times do
  puts x # => 2
end

pc = proc { x } #=> #<Proc:0x007fb333164818@closure.rb:10>
pc.call #=> 2

l = lambda { x } #=> #<Proc:0x007fb3331646b0@closure.rb:13 (lambda)>
l.call #=> 2

def hoge
  x
end

hoge
#=> NameError: undefined local variable or method `x' for main:Object
# メソッドは定義時のローカル変数を参照できません

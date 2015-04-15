class Hoge
end

h = Hoge.new
p h.respond_to?(:hi) #=> false

# 特異メソッド = 特定のオブジェクトにのみ定義されたメソッド
def h.hi
 "hi!"
end

# "h"オブジェクトだけに新しいメソッド"hi"が定義されている
p h.respond_to?(:hi) # => true
p h.hi # => "hi!"
p h.singleton_methods # => [:hi]

# Hogeクラスのインスタンスを新しく作っても"hi"メソッドは存在しない
h2 = Hoge.new
p h2.respond_to?(:hi) # => false

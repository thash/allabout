class X
  def initialize(val)
    @val = val
  end
end

x = X.new(12345)

# アクセサを定義してないのでこれでは呼び出せないが...
puts x.val
#=> undefined method `val' for #<X:0x007f914d088898 @val=12345> (NoMethodError)

# x内のコンテキストで評価すれば@valを参照できる
x.instance_eval('puts @val') # => 12345

# ブロックで書くことも出来る
x.instance_eval do
  puts @val * 2
end # => 24690

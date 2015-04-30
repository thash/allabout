class Greeting
  attr_reader :msg
  def initialize(msg)
    @msg = msg
  end
end

hi = Greeting.new("Hi!")
ho = Greeting.new("Ho!")

# 通常の==演算子の挙動
p hi == hi #=> true
p hi == ho #=> false

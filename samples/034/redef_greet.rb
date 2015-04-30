class Greeting
  attr_reader :msg
  def initialize(msg)
    @msg = msg
  end
  def ==(other)
    return true if self.msg.index(/!$/) && other.msg.index(/!$/)
    false
  end
end

hi = Greeting.new("Hi!")
ho = Greeting.new("Ho!")

p hi == hi #=> true
p hi == ho #=> true

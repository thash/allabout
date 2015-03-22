class C
  attr_reader :bind
  def initialize(val)
    @bind = binding
  end
end

c = C.new(999)
c.val
#=> undefined method `val' for #<C:0x007fef31888bc8 @bind=#<Binding:0x007fef31888b78>> (NoMethodError)

# initialize内のコンテキストが保持されているので、valにアクセスできる
p c.bind #=> #<Binding:0x007fb50a088b28>
eval('puts val', c.bind) #=> 999

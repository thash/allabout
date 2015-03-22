class Hoge
  def initialize(n)
    @n = n
  end
end

h = Hoge.new(123)
p h.instance_variables # => [:@n]

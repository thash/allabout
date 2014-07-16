class Rectangle
  def initialize(x, y)
    @x = x; @y = y
  end

  def area
    @x * @y
  end
end
rect = Rectangle.new(4, 5)

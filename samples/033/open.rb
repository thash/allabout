obj = Object.new
p obj.singleton_class #=> #<Class:#<Object:0x007f8cbb9bf0d8>>

class << obj
  #  特異クラスのコンテキストに移る
  p self #=> #<Class:#<Object:0x007f8cbb9bf0d8>>

  def hi
    "hi"
  end
end

# 特異メソッドが追加されている
p obj.hi #=> hi

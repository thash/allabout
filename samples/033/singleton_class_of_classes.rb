p String.class #=> Class
p String.singleton_class #=> #<Class:String>

# オブジェクト"String"の特異クラスをオープン
class << String
  p self #=> #<Class:String>

  def shout(str)
    str + '!!!'
  end
end

p String.shout('wei') #=> wei!!!

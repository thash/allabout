# 空のクラスを用意
class Hoge
end

# インスタンスメソッドを定義
Hoge.class_eval("def dice; puts #{rand(1000)} end")

h = Hoge.new
h.dice # => 532, など

Hoge.class_eval do
  (0..10).map{|i| 2**i }.each do |n|
    attr_accessor :"val#{n}"
  end
end

h2 = Hoge.new
p h2.val1024 # => nil
p h2.val1024 = 3 # => 3

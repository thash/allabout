class Hoge; end

# あらゆるクラスは"Class"クラスのインスタンス
p String.instance_of? Class #=> true

p String.class  #=> Class
p Array.class   #=> Class
p Integer.class #=> Class
p Hoge.class    #=> Class

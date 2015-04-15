class Knife
  def cut(sth)
    sth.to_s.split('').join('|')
  end


  # クラスメソッドの定義その(1)
  def self.hoge
    'hoge'
  end

  # クラス定義スコープ中のselfは"Knife"なので
  p self # => Knife

  # クラスメソッドの定義その(2)
  # こう書いても同じ. このように名前で参照するならclass...end外でもOK
  def Knife.fuga
    'fuga'
  end

  # クラスメソッドの定義その(3)
  class << self
    # ここのselfはKnifeオブジェクトの特異クラス
    p self #=> #<Class:Knife>
    def piyo
      'piyo'
    end
  end
end

knife = Knife.new
p knife.cut("tomato") #=> "t|o|m|a|t|o"


p Knife.hoge #=> "hoge"
p Knife.fuga #=> "fuga"
p Knife.piyo #=> "piyo"

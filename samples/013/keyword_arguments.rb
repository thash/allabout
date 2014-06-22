def cube(n)
  n ** 3 # nが仮引数
end
# p cube(2) #=> 8

def cube(n: 1)
  n ** 3
end
# p cube(n: 2) #=> 8
# p cube(2)    #=> in `cube': wrong number of arguments (1 for 0) (ArgumentError)
# p cube       # => 1

class Coffee
  def initialize(size, hot=true, milk=:normal, flavor=nil, cream=1.0)
    @size = size
    @temp = hot ? :hot : :cold
    @milk = milk
    @flavor = flavor
    @cream = cream
  end
end

Coffee.new(:Tall).inspect
#=> "#<Coffee:0x007fc76c8c6a50 @size=:Tall, @temp=:hot, @milk=:normal, @flavor=nil, @cream=1.0>"
Coffee.new(:Tall, false).inspect
#=> "#<Coffee:0x007fc76c8c67d0 @size=:Tall, @temp=:cold, @milk=:normal, @flavor=nil, @cream=1.0>"
Coffee.new(:Tall, false, :soy).inspect
#=> "#<Coffee:0x007fc76c8c65c8 @size=:Tall, @temp=:cold, @milk=:soy, @flavor=nil, @cream=1.0>"


# 問題1: 引数の順番を間違えた
Coffee.new(:Tall, :soy, false).inspect
#=> "#<Coffee:0x007fc20b01a340 @size=:Tall, @temp=:hot, @milk=false, @flavor=nil, @cream=1.0>"

# 問題2: ホイップクリームを多めにしたいだけで他はデフォルトのままなのに、
#        間にあるすべての引数を書かないといけない
Coffee.new(:Tall, true, :normal, nil, 1.2).inspect
#=> "#<Coffee:0x007fc20b01a160 @size=:Tall, @temp=:hot, @milk=:normal, @flavor=nil, @cream=1.2>"


class Coffee
  def initialize(size, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    @size   = size
    @temp   = options[:hot] == false ? :cold : :hot
    @milk   = options[:milk]   || :normal
    @flavor = options[:flavor] || nil
    @cream  = options[:cream]  || 1.0
  end
end

# ハッシュ要素なので順不同
Coffee.new(:Tall, milk: :soy, hot: false).inspect
#=> "#<Coffee:0x007facab0ec9c8 @size=:Tall, @temp=:cold, @milk=:soy, @flavor=nil, @cream=1.0>"

# デフォルトから変えたいもののみ渡せる
Coffee.new(:Tall, cream: 1.2).inspect
#=> "#<Coffee:0x007fef7b0e6948 @size=:Tall, @temp=:hot, @milk=:normal, @flavor=nil, @cream=1.2>"


class Coffee
  def initialize(size, hot: true, milk: :normal, flavor: nil, cream: 1.0)
    @size   = size
    @temp   = hot ? :hot : :cold
    @milk   = milk
    @flavor = flavor
    @cream  = cream
  end
end

Coffee.new(:Tall, milk: :soy, hot: false).inspect
#=> "#<Coffee:0x007facab0ec9c8 @size=:Tall, @temp=:cold, @milk=:soy, @flavor=nil, @cream=1.0>"

Coffee.new(:Tall, cream: 1.2).inspect
#=> "#<Coffee:0x007fef7b0e6948 @size=:Tall, @temp=:hot, @milk=:normal, @flavor=nil, @cream=1.2>"


def cube(n: )
  n ** 3
end

p cube(n: 2) #=> 8
p cube       #=> missing keyword: n (ArgumentError)

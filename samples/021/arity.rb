# lambdaで作成した手続きオブジェクト
l0 = lambda {|n, m| p n, m }

# 引数の数が間違っているとエラーになる
l0.call(1)       #=> diff.rb:9:in `block in <main>': wrong number of arguments (1 for 2) (ArgumentError)
l0.call(1, 2, 3) #=> diff.rb:16:in `block in <main>': wrong number of arguments (3 for 2) (ArgumentError)



# procで作成した手続きオブジェクト
p0 = proc {|n, m| p n, m }

# 足りない引数をnilで埋め、
p0.call(1)
# => 1
# => nil

# 余分な引数は無視する
p0.call(1, 2, 3)
# => 1
# => 2

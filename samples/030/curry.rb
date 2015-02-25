def mul(a, b)
  a * b
end

# メソッドオブジェクトを取得
m = method(:mul) #=> #<Method: Object#mul>

# Methodをcurry化するとProcになります
p prc = m.curry #=> #<Proc:0x007fe0fa08a6c8 (lambda)>

# カリー化されたprocに対して、引数の部分適用が可能になります
p mul10 = prc.call(10) #=> #<Proc:0x007fea15885e08 (lambda)>

# のこりひとつの引数を適用します
p mul10.call(21) #=> 210

# ちなみに.call(xxx)は.(xxx)とも書けます
p mul10.(21)

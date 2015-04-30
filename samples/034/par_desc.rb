T = true
F = false

bool = T and F

# 上の式は演算子優先順位により
# 以下のように解釈され、この時点でboolにはTが代入される
(bool = T) and F

# andの左側はT(true)となっており、boolへの代入後にandが評価される
# この結果は単に捨てられる
true and F

# その次の行でboolを参照すると、(bool = T)で代入されたとおりtrueが出力される
p bool #=> true

# カッコを使えば意図通りに動く
bool = (T and F)
p bool #=> false

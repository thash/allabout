p [1, 3, :a, 4, 5, 6].slice_before{|e| e.is_a? Symbol}.to_a
#=> [[1, 3], [:a, 4, 5, 6]]

p [1, 3, :a, 4, 5, 6].slice_after{|e| e.is_a? Symbol}.to_a
#=> [[1, 3, :a], [4, 5, 6]]

# ブロックの中身がis_aならクラスを受け取って次のように書いても同じ
[1, 3, :a, 4, 5, 6].slice_after(Symbol).to_a

# slice_when
p [1, 3, 4, 5, 6, 8, 10, 12].slice_when{|e| e.odd? }.to_a
#=> [[1], [3], [4, 5], [6, 8, 10, 12]]

# 比較もできる. 値が2以上ジャンプしたところでsliceする例
p [1, 3, 4, 5, 6, 8, 10, 12].slice_when{|e1, e2| e1 + 1 < e2 }.to_a
#=> [[1], [3, 4, 5, 6], [8], [10], [12]]

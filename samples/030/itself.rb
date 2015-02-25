ary = [2, 3, 0, 3, 4, 2, 4, 3, 0, 2]
ary.group_by(&:itself)
#=> {2=>[2, 2, 2], 3=>[3, 3, 3], 0=>[0, 0], 4=>[4, 4]}

# 2.1以前はitselfがないのでこう書くしかない
ary.group_by{|i| i }
#=> {2=>[2, 2, 2], 3=>[3, 3, 3], 0=>[0, 0], 4=>[4, 4]}

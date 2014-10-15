p [1, 2, 3].map {|n| n ** n }     #=> [1, 4, 27]
p [1, 2, 3].map do |n| n ** n end #=> #<Enumerator: [1, 2, 3]:map>

# do...endがmapの引数と認識されておらず、以下のように解釈されている
p [1, 2, 3].map                   #=> #<Enumerator: [1, 2, 3]:map>

# カッコで括り、map後のdo...endまで含めてpの引数であることを明示すれば意図通りに動く
p([1, 2, 3].map do |n| n ** n end) #=> [1, 4, 27]

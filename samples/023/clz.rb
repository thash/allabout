def checker(obj)
  case obj
  when String
    '文字列です'
  when Symbol
    'シンボルです'
  when Integer
    '整数です'
  else
    '???'
  end
end

puts checker('hogehoge') #=> 文字列です
puts checker(:hogehoge)  #=> シンボルです
puts checker(nil)        #=> ???

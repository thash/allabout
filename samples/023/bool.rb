def judge(cond)
  if cond
    puts 'TRUE!!'
  else
    puts 'FALSE!!'
  end
end

judge(0)       #=> TRUE!!
judge(999)     #=> TRUE!!
judge('hoge')  #=> TRUE!!
judge('')      #=> TRUE!!
judge([])      #=> TRUE!!
judge(true)    #=> TRUE!!

judge(false)   #=> FALSE!!
judge(nil)     #=> FALSE!!

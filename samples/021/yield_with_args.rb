def iter_with_args
  puts '------------'
  yield(10, 2) # yieldに引数を渡し、ブロック側で利用します
  puts '============'
end

# yieldに渡されたブロック引数を参照します
iter_with_args do |n, m|
  puts n * m
end
#=> ------------
#=> 20
#=> ============

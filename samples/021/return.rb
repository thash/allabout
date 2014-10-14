def wrap_lambda
  l0 = lambda { return :lambda }
  puts 'before call'
  p l0.call
  puts 'after call'
end

wrap_lambda
#=> before call
#=> :lambda
#=> after call


def wrap_proc
  p0 = proc { return :proc }
  puts 'before call'
  p p0.call
  puts 'after call'
end

wrap_proc
#=> before call

def iter_with_args2(first, second)
  yield first - 1, second + 1
end

iter_with_args2(10, 2) do |n, m|
  # n, mにはiter_with_args2中で加減された数値が渡される
  puts n * m
end
# => 27

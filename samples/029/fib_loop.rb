def fibonacci(n)
  return 0 if n == 0
  prev, current = 0, 1
  2.upto(n) do
    prev, current = current, prev + current
  end
  current
end

puts fibonacci(100000)

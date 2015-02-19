# n = 1のテストを追加し...
assert_equal 1, fibonacci(1)

# 0, 1の両方で通るように修正します
def fibonacci(n)
  return 0 if n == 0
  return 1 if n == 1
end

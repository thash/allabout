class TestFibonacci < Minitest::Test
  def test_fibonacci_init
    assert_equal 0, fibonacci(0)
    assert_equal 1, fibonacci(1)
  end

  def test_fibonacci_n
    assert_equal 1, fibonacci(2)
    assert_equal 2, fibonacci(3)
    assert_equal 3, fibonacci(4)
    assert_equal 5, fibonacci(5)
    assert_equal 8, fibonacci(6)

    assert_equal 55, fibonacci(10)
    assert_equal 102334155, fibonacci(40)
  end
end

